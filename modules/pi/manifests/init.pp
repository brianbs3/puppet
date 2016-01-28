class pi {
  package {
      ['git', 'ntpdate', 'vim', 'mysql-client', 'apache2', 'curl', 'php5-memcache', 'php5-memcached', 'php5-common', 'php5-mysql', 'libapache2-mod-php5', 'memcached', 'mysql-server', 'munin-node', 'python-pip']:
        ensure => latest,
        require => Class['apt'],
        notify => Service['apache2', 'mysql', 'memcached'];
  }
  file{
    '/etc/ssh/ssh_config':
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/ssh_config";

    'git_update_check':
      path => '/usr/local/bin/git_update_check',
      source => 'puppet:///modules/common/git_update_check',
      ensure => present,
      mode => 0755;
    '/usr/lib/php5/20090626':
      ensure => 'link',
      target => '/usr/lib/php5/20100525+lfs';
    '/data':
      path => '/data',
      ensure => "directory",
      owner  => root,
      group  => root,
      mode   => "0755";
    '/data/nas':
      path => '/data/nas',
      ensure => "directory",
      owner  => root,
      group  => root,
      mode   => "0755",
      require => File['/data'];

    "/home/bs":
      ensure => "directory",
      owner  => bs,
      group  => bs,
      mode   => "0755";
  
    "/home/bs/.vimrc":
      mode => 644,
      owner => bs,
      group => bs,
      source => "puppet:///modules/common/vimrc",
      require => File['/home/bs'];

    "/home/bs/.bashrc":
      mode => 644,
      owner => bs,
      group => bs,
      source => "puppet:///modules/common/bashrc",
      require => File['/home/bs'];

      "/etc/apache2":
        ensure => 'directory';

    "/etc/apache2/mods-available/status.conf":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/status.conf",
      require => File['/etc/apache2'],
      notify => Service['apache2'];

    "/etc/apache2/mods-available/status.load":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/status.load",
      require => File['/etc/apache2'],
      notify => Service['apache2'];
  
    "/home/bs/.ssh":
      ensure => "directory",
      owner  => bs,
      group  => bs,
      mode   => "0700",
      require => File['/home/bs'];
  
    "/home/bs/.ssh/id_rsa":
      mode => 600,
      owner => bs,
      group => bs,
      source => "puppet:///modules/common/bs_id_rsa",
      require => File['/home/bs/.ssh'];
  
  "/home/bs/.ssh/authorized_keys":
      mode => 600,
      owner => bs,
      group => bs,
      require => File['/home/bs/.ssh'];

    "/etc/memcached.conf":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/memcached.conf",
      notify => Service['memcached'];
  
    "/etc/munin/munin-node.conf":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/munin-node.conf",
      notify => Service['munin-node'],
      require => Package['munin-node'];
  
    "/etc/localtime":
      ensure => "link",
      target => "/usr/share/zoneinfo/America/New_York",
      notify => Service['ntp'],
      require => Package['ntp'];

    "/etc/timezone":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/common/timezone",
      notify => Service['ntp'],
      require => Package['ntp'];
  
    "/usr/local/bin/run-puppet.sh":
      mode => 744,
      owner => root,
      group => root,
      source => "puppet:///modules/common/run-puppet.sh";
      #require => File['/home/bs'];

#    "/etc/apt/sources.list.d/bsserver.list":
#      mode => 755,
#      owner => root,
#      group => root,
#      source => "puppet:///modules/common/bsserver.list";
    'pi.txt':
      path => "/tmp/pi.txt",
      ensure => "present",
      owner => pi,
      group => pi,  
      mode => 0744;

    "/etc/rc.local":
      mode => 755,
      owner => root,
      group => root,
      source => "puppet:///modules/pi/rc.local";

    "/etc/apt/sources.list.d/bsserver.list":
      mode => 755,
      owner => root,
      group => root,
      source => "puppet:///modules/pi/bsserver.list";

    "/etc/network/interfaces":
      mode => 644,
      owner => root,
      group => root,
      source => "puppet:///modules/pi/interfaces";

    "/usr/local/bin/Adafruit_DHT":
      mode => 755,
      owner => root,
      group => root,
      source => "puppet:///modules/pi/Adafruit_DHT";
  }

  mount { "/data/nas":
    device  => "bsnas.home.bs:/mnt/array1/share",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "defaults",
    atboot  => "true",
    require => [Service['rpcbind'], File['/data/nas']];
  }

  service{

    'rpcbind':
      ensure => running;
    'apache2':
      ensure => true,
      enable => true;
    'mysql':
      ensure => true,
      enable => true;
    'memcached':
      ensure => true,
      enable => true;
    'munin-node':
      ensure => true,
      enable => true;
  }

  class {
    '::ntp':
      servers => [ 'bsserver.home.bs' ];
  }
#  tidy{
#    'zm':
#      path => "/var/cache/zoneminder/events",
#      age => "6m",
#      recurse => true,
#      matches => [ "*.jpg" ],
#  }
}
