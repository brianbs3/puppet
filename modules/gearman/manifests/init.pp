class gearman{ 

  package {
      #['git', 'ntpdate', 'vim', 'mysql-client', 'apache2', 'curl', 'php5-memcache', 'php5-memcached', 'php5-common', 'php5-mysql', 'libapache2-mod-php5', 'memcached', 'mysql-server', 'munin-node']:
      #['libgearman6', 'libgearman-client-perl', 'libgearman-client-async-perl', 'mod-gearman-worker', 'mod-gearman-tools', 'gearman', 'gearman-server', 'gearman-job-server', 'gearman-tools', 'python-gearman', 'gcc', 'autoconf', 'bison', 'flex', 'libtool', 'make', 'libboost-all-dev', 'libcurl4-openssl-dev',  'libevent-dev', 'uuid-dev', 'libsqlite3-dev', 'libmysqlclient-dev']:
      ['supervisor', 'libgearman6', 'libgearman-client-perl', 'mod-gearman-worker', 'mod-gearman-tools', 'gearman', 'gearman-server', 'gearman-job-server', 'gearman-tools', 'python-gearman', 'gcc', 'autoconf', 'bison', 'flex', 'libtool', 'make', 'libboost-all-dev', 'libcurl4-openssl-dev',  'libevent-dev', 'uuid-dev', 'libsqlite3-dev', 'libmysqlclient-dev']:
        ensure => latest,
        require => Class['apt'],
        notify => Service['gearman-server', 'gearman-job-server'];
  }
#  
  service {
    'gearman-server':
      ensure => true,
      enable => true;
    'gearman-job-server':
      ensure => true,
      enable => true;
#    'mysql':
#      ensure => true,
#      enable => true;
#    'memcached':
#      ensure => true,
#      enable => true;
#    'munin-node':
#      ensure => true,
#      enable => true;
##    'rpcbind':
##      ensure => true,
##     enable => true;
  }
  file { 
    '/usr/lib/php5/20090626/gearman.so':
      source => "puppet:///modules/gearman/gearman.so",
      owner  => root,
      group  => root,
      mode   => "0755";
    '/etc/php5/conf.d/gearman.ini':
      source => "puppet:///modules/gearman/gearman.ini",
      owner  => root,
      group  => root,
      mode   => "0755";
    "/opt/gearman":
      ensure => "directory",
      owner  => bs,
      group  => bs,
      mode   => "0755";
  }
  exec {
    'git_clone_gearman':
      command => '/usr/bin/git clone -q git@bsserver.home.bs:bs/gearman.git /opt/gearman',
      user  => 'bs',
      unless => '/usr/bin/test -d /opt/gearman/.git',
      require => [File['/opt/gearman', '/home/bs/.ssh/id_rsa', '/etc/ssh/ssh_config'], Package['git']];

    'git_update_gearman':
      command => '/usr/bin/git pull',
      require => [ Package['git'], Exec['git_clone_gearman'], File['/home/bs/.ssh/id_rsa'], File['git_update_check'] ],
      cwd => '/opt/gearman',
      user => 'bs',
      unless => '/usr/local/bin/git_update_check';
  }
#  
#  
#  class {
#    '::ntp':
#      servers => [ 'bsserver.home.bs' ];
#  
##    'apt': 
##      purge_sources_list   => true,
##      purge_sources_list_d => true;
#  }
#
#  class { 'sudo': }
#    sudo::conf { 'bs':
#      priority => 10,
#      content  => 'bs ALL=(ALL) NOPASSWD: ALL';
#  }
#
#  group { 
#    "bs":
#      ensure => present,
#      gid => 1005;
#    "puppet":
#      ensure => "present";
#  }
#  user { 
#    "bs":
#      ensure => present,
#      gid => "bs",
#      groups => ["sudo"],
#      membership => minimum,
#      shell => "/bin/bash",
#      require => Group["bs"];
#    "memcache":
#      ensure => present,
#      system => true;
#  }
#  ssh_authorized_key { 
#    'bs@bsserver':
#      name    => "bs_ssh_key",
#      ensure  => present,
#      key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDFy0n9QhOjE2r5rcRDooMkR+asCcwDB9yMgrzHyG+Boevt1158wNK19QbiL4xeUkCSQXa2uXFtqwv4wR8LbwNWELOmLq8pHiewbqINHlxNejcIcWclAzwf50WwfmHwJ+n8j0NR2hSlY35aCQ7T8cSzJJDjOYBkFiZg/xX7Cke3jqtpMZdyWNzUxEB2acjqbsPD+a4vTqPpIt0hFSSAvVGYfcL2wCcaVQRJz8CCJsK5CBpCp0K8Ee2t50WaDzDwRlGhkGx0LrjbdwMgdhCK/sDYxhBHlIz+Mv3qdlfZnkM+oQN4ZBZVXShKHTYosRJSqI5xni49currA8LvicCR/5WZ",
#      type    => "rsa",
#      user    => bs,
#      require => File['/home/bs/.ssh/authorized_keys'];
#
#    'bs@Brians-iMac':
#      name    => "bs_imac_ssh_key",
#      ensure  => present,
#      key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDQBe+WkgrRH/senf85w+HY7QqGmLescIGPFMZBTkF05QD+EFf3sTKES0HnzbbGEza6At7iz37mw1UZ+I7a4yygw0JD7Wf1TYeVQO1y0PGIpw6f0dZpa3h6pkEoKIcTtSTJAUpGFd97zzgeUeCt/+Igy+V3gLizpwUIYylaNBnwxBKVm2YIrPBFT11ExVAnYmtrQycD9Fn8jCzT0rqeXM+d7QP1uyxuiAkZeQ/IFdYPCbOkwDDoR9Qg66v74dsoS92fogNNeBfVxwce7hQrykz04ruMCPPVmN2be+hUQXqK3NG95r8vIdDbIjtghE05S/KxBMD0pVsSh9dJZ+zFeCtJ",
#      type    => "rsa",
#      user    => bs,
#      require => User["bs"];
#
#    'bsizemore@Brian-Sizemores-MacBook-Pro':
#      name    => "bs_macbook_pro_ssh_key",
#      ensure  => present,
#      key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDHDssmG+QZ/57wrxAzD8yoDUcpe/7PrxJukJ5/LNU6Q+M7pJbgVIQ/yXlJGM/AxQ4IJbvMKS/XKVIMFm/LQqbAdIt1Mv+AS7M0aJ3woqiQF3yk7Ct38kEvBer+MlZPdHHeX35y0TITXIsnHOmyx9N3pTdhoG5xfN0hc/M4rLVSmLwi/K5U/DUXQXZ9nO3T6JB4YwVI3VVTthbS7f9Ha+VppiyhxrFup/MCloSm8FwakoGHINMy7ME5uiJPBlIvMqHUeGIig5wtqBwZgo+H+vFN1GEw+9e3zHnf+Uzkb0mzycBP0hj1n7/ZZ7FUsE+HQ2YbjRIICT3NoZlzah5NFdKp",
#      type    => "rsa",
#      user    => bs,
#      require => User["bs"];
#
#    'bsizemore@Brian-Sizemores-MacBook-Air':
#      name    => "bs_macbook_air_ssh_key",
#      ensure  => present,
#      key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDayGO+XPszsIyXyJ2MvEBLAOxrKMb6j5XVtHcWjnMDqYRXyds1SwCzt+7Q0UvIV+T+z3VJsX6nrGbVJQogAhGmes2HCugP52B4eUl1Ox4l+j+ppsgq5G5zBMC5rmx2s3ufZp1zp7UfIHihKqfNgPXKQOUavcHLdPS9comjPfzVISjmlYM1ZaoC4aKtegXrMg1qSAaCCQ6hQZ8pvbh5r5kz8JFkQTXvEOW1QAY4lTaKWfPPFier0KNA7x33lUYKuP7vsl5QwDH8reEQmxFflxyEzNCcnmwIhFww9aT7yq/J3qzVrrjaNUh839T8AziE0T7cPYynOh/GOw0UMCnKve89",
#      type    => "rsa",
#      user    => bs,
#      require => User["bs"];
#}
#
#  cron{
#      'run-puppet':
#        command => "/usr/local/bin/run-puppet.sh 2&>1 /dev/null",
#        minute => '*/15',
#        #require => Package['puppet'],
#        ensure => present;
#        #ensure => absent;
#
#      'puppetd':
#        command => "/opt/vagrant_ruby/bin/puppetd 2&>1 /dev/null",
#        minute => '*/15',
#        #require => Package['puppet'],
#        #ensure => present;
#        ensure => absent;
#  }
#
##  mount { "/data/nas":
##    device  => "bsnas.home.bs:/mnt/array1/share",
##    fstype  => "nfs",
##    ensure  => "mounted",
##    options => "defaults",
##    atboot  => "true",
##    require => [File['/data/nas']];
##  }
#class { 'snmp':
#  agentaddress => [ 'udp:161', ],
#  ro_community => 'bs',
#  ro_network   => '192.168.1.0/32',
#  contact      => 'root@yourdomain.org',
#  location     => 'My House',
#  views       => [ 'systemview included .1', ],
#  install_client => true,
#  snmp_config    => [ 'defVersion 2c', 'defCommunity bs', 'mibdirs +/usr/local/share/snmp/mibs', ],
#  require => Class['apt'],
#  #require  => Exec['apt-get update'],
#}
#
}
