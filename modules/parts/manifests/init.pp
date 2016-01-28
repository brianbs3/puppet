class parts{

  $dbserver = '192.168.1.99'
  file { 
#
#    'parts_web':
#      path    => "/var/www/parts",
#      ensure  => "directory",
#      owner   => bs,
#      group   => bs,
#      mode    => "0755",
#      require => Package['apache2'];
    '/var/www/parts':
      recurse => true,
      ensure => directory;
#      require => Exec['git_update'];
    'web':
      path    => "/var/www",
      ensure  => "directory",
      owner   => bs,
      group   => bs,
      mode    => "0755",
      require => Package['apache2'];
  
    'parts_application':
      path    => "/var/www/parts/application",
      ensure  => "directory",
      owner   => bs,
      group   => bs,
      mode    => "0777",
      require => Exec['git_clone'];
  
    'parts_log':
      path    => "/var/www/parts/application/logs",
      ensure  => "directory",
      owner   => bs,
      group   => bs,
      mode    => "0777",
      require => File['parts_application'];
  
    'ci_database_config':
      path => "/var/www/parts/application/config/database.php",
      ensure => "present",
      owner  => bs,
      group  => bs,
      mode   => "0755",
      content => template("parts/database.php.erb"),
      require => [ Package['apache2'], File['parts_application'] ];
  
    'ci_config_config':
      path => "/var/www/parts/application/config/config.php",
      ensure => "present",
      owner  => bs,
      group  => bs,
      mode   => "0755",
      content => template("parts/config.php.erb"),
      require => [ Package['apache2'], File['parts_application'] ];
  }

  exec {
    'git_clone':
      command => '/usr/bin/git clone -q git@bsserver.home.bs:bs/parts.git /var/www/parts',
#      cwd => '/var/www/parts',
      user  => 'bs',
      unless => '/usr/bin/test -d /var/www/parts/.git',
      require => [File['web', '/home/bs/.ssh/id_rsa', '/etc/ssh/ssh_config'], Package['git']];

    'git_update':
      command => '/usr/bin/git pull',
      require => [ Package['git'], File['/var/www/parts'], Exec['git_clone'], File['/home/bs/.ssh/id_rsa'], File['git_update_check'] ],
      cwd => '/var/www/parts',
      user => 'bs',
      unless => '/usr/local/bin/git_update_check';
  }
}
