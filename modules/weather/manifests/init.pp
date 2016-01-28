class weather{
  package {
      ['rrdtool', 'libcql-parser-perl', 'php5-dev', 'libpcre3-dev', 'pkg-config', 'g++']:
        ensure => latest,
        require => Class['apt'];

      ['php5-rrd']:
        ensure => latest,
        notify => Service['apache2'],
        require => Class['apt'];
  }

  file { 
    "/opt/bsWeather":
      ensure => "directory",
      owner  => bs,
      group  => bs,
      mode   => "0755";

    "/opt/bsWeather/rrd":
      ensure => "directory",
      owner  => bs,
      group  => bs,
      mode   => "0755",
      require => Exec['git_update_weather'];

    "/etc/apache2/mods-enabled/weather.conf":
      ensure => "link",
      target => "/etc/apache2/mods-available/weather.conf",
      notify => Service['apache2'],
      require => File['/etc/apache2/mods-available/weather.conf'];
      
    "/etc/apache2/mods-available/weather.conf":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/weather/weather.conf",
      notify => Service['apache2'],
      require => Package['apache2'];

#    'git_update_check_weather':
#      path => '/usr/local/bin/git_update_check',
#      source => 'puppet:///modules/weather/git_update_check',
#      ensure => present,
#      mode => 0755;
#    '/var/www/weather':
#      recurse => true,
#      owner => bs,
#      group => bs,
#      ensure => directory;

#    'web_weather':
#      path    => "/var/www",
#      ensure  => "directory",
#      owner   => bs,
#      group   => bs,
#      mode    => "0755",
#      require => Package['apache2'];
  
#    'web_www_weather':
#      path    => "/var/www/weather",
#      ensure  => "directory",
#      owner   => bs,
#      group   => bs,
#      mode    => "0777",
#      require => File['web_weather'];
      #require => Exec['git_clone_weather'];
  }

  exec {
    'git_clone_weather':
      command => '/usr/bin/git clone -q git@bsserver.home.bs:bs/weather.git /opt/bsWeather',
#      cwd => '/var/www/weather',
      user  => 'bs',
      unless => '/usr/bin/test -d /opt/bsWeather/.git',
      require => [File['/opt/bsWeather', '/home/bs/.ssh/id_rsa', '/etc/ssh/ssh_config'], Package['git']];

    'git_update_weather':
      command => '/usr/bin/git pull',
      require => [ Package['git'], Exec['git_clone_weather'], File['/home/bs/.ssh/id_rsa'], File['git_update_check'] ],
      cwd => '/opt/bsWeather',
      user => 'bs',
      unless => '/usr/local/bin/git_update_check';

  'create_pi_weather':
    command => '/opt/bsWeather/create_pi_weather.sh',
    cwd => '/opt/bsWeather',
    require => [File['/opt/bsWeather/rrd'], Package['rrdtool']],
    unless => '/usr/bin/test -f /opt/bsWeather/rrd/created';

  }

  cron {

      'update_memcache_cron':
        command => "/usr/bin/php /opt/bsWeather/update_memcache.php 2&>1 /dev/null",
        minute => '*',
        require => File['/opt/bsWeather'],
        ensure => present;

      'graph_pi_weather_cron':
        command => "/opt/bsWeather/graph_pi_weather.sh 2&>1 /dev/null",
        minute => '*',
        require => File['/opt/bsWeather'],
        ensure => present;

      'backup_pi_weather_cron':
        command => "/opt/bsWeather/backup_pi_weather.sh 2&>1 /dev/null",
        minute => '*/10',
        require => File['/opt/bsWeather'],
        ensure => present;

  }
}
