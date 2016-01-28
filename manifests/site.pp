$root_dotssh = "${root_home}/.ssh"


#package {
#  'git':
#    ensure => installed,
#    require => Class['apt']
#}
#
#package {
#  'vim':
#    ensure => installed,
#    require => Class['apt']
#}
#
#package {
#  'mysql-client':
#    ensure => installed,
#    require => Class['apt']
#}


#file { "/tmp/test2.txt":
#    mode => 660,
#    owner => root,
#    group => root,
#    source => "puppet:///modules/common/test.txt"
#}

#file { "/home/bs":
#  ensure => "directory",
#  owner  => bs,
#  group  => bs,
#  mode   => "0755";
#}

#file{ 
#  "/home/bs/.vimrc":
#  
#    mode => 644,
#    owner => bs,
#    group => bs,
#    source => "puppet:///modules/common/vimrc",
#    require => File['/home/bs'];
#}
#
#file { "/home/bs/.ssh":
#  ensure => "directory",
#  owner  => bs,
#  group  => bs,
#  mode   => "0700",
#  require => File['/home/bs'];
#}
#file{ "/home/bs/.ssh/id_rsa":
#  
#    mode => 600,
#    owner => bs,
#    group => bs,
#    source => "puppet:///modules/common/bs_id_rsa",
#    require => File['/home/bs/.ssh'];
#}
#file { "/home/bs/.ssh/authorized_keys":
#    mode => 600,
#    owner => bs,
#    group => bs,
#    require => File['/home/bs/.ssh'];
#
#}

#class { '::ntp':
#  servers => [ 'bsserver.home.bs' ],
#}

#  class { 'sudo': }
#  sudo::conf { 'bs':
#    priority => 10,
#    content  => 'bs ALL=(ALL) NOPASSWD: ALL',
#}

#group { "bs":
#        ensure => present,
#        gid => 1005
#}
#user { "bs":
#        ensure => present,
#        gid => "bs",
#        groups => ["sudo"],
#        membership => minimum,
#        shell => "/bin/bash",
#        require => Group["bs"]
#}
#ssh_authorized_key { 'bs@bsserver':
#  name    => "bs_ssh_key",
#  ensure  => present,
#  key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDFy0n9QhOjE2r5rcRDooMkR+asCcwDB9yMgrzHyG+Boevt1158wNK19QbiL4xeUkCSQXa2uXFtqwv4wR8LbwNWELOmLq8pHiewbqINHlxNejcIcWclAzwf50WwfmHwJ+n8j0NR2hSlY35aCQ7T8cSzJJDjOYBkFiZg/xX7Cke3jqtpMZdyWNzUxEB2acjqbsPD+a4vTqPpIt0hFSSAvVGYfcL2wCcaVQRJz8CCJsK5CBpCp0K8Ee2t50WaDzDwRlGhkGx0LrjbdwMgdhCK/sDYxhBHlIz+Mv3qdlfZnkM+oQN4ZBZVXShKHTYosRJSqI5xni49currA8LvicCR/5WZ",
#  type    => "rsa",
#  user    => bs,
#  require => File['/home/bs/.ssh/authorized_keys'],
#  #require => User["bs"] => File['/home/bs/.ssh'] => File['/home/bs/.ssh/authorized_keys'],
#}
#ssh_authorized_key { 
#  'bs@Brians-iMac':
#  name    => "bs_imac_ssh_key",
#  ensure  => present,
#  key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDQBe+WkgrRH/senf85w+HY7QqGmLescIGPFMZBTkF05QD+EFf3sTKES0HnzbbGEza6At7iz37mw1UZ+I7a4yygw0JD7Wf1TYeVQO1y0PGIpw6f0dZpa3h6pkEoKIcTtSTJAUpGFd97zzgeUeCt/+Igy+V3gLizpwUIYylaNBnwxBKVm2YIrPBFT11ExVAnYmtrQycD9Fn8jCzT0rqeXM+d7QP1uyxuiAkZeQ/IFdYPCbOkwDDoR9Qg66v74dsoS92fogNNeBfVxwce7hQrykz04ruMCPPVmN2be+hUQXqK3NG95r8vIdDbIjtghE05S/KxBMD0pVsSh9dJZ+zFeCtJ",
#  type    => "rsa",
#  user    => bs,
#  require => User["bs"],
#}
#ssh_authorized_key { 
#'bsizemore@Brian-Sizemores-MacBook-Pro':
#  name    => "bs_macbook_pro_ssh_key",
#  ensure  => present,
#  key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDHDssmG+QZ/57wrxAzD8yoDUcpe/7PrxJukJ5/LNU6Q+M7pJbgVIQ/yXlJGM/AxQ4IJbvMKS/XKVIMFm/LQqbAdIt1Mv+AS7M0aJ3woqiQF3yk7Ct38kEvBer+MlZPdHHeX35y0TITXIsnHOmyx9N3pTdhoG5xfN0hc/M4rLVSmLwi/K5U/DUXQXZ9nO3T6JB4YwVI3VVTthbS7f9Ha+VppiyhxrFup/MCloSm8FwakoGHINMy7ME5uiJPBlIvMqHUeGIig5wtqBwZgo+H+vFN1GEw+9e3zHnf+Uzkb0mzycBP0hj1n7/ZZ7FUsE+HQ2YbjRIICT3NoZlzah5NFdKp",
#  type    => "rsa",
#  user    => bs,
#  require => User["bs"],
#}
#class { 'precise64': 
#    require => Package['apache2'],
#}
#node 'precise64.home.bs' {
# group { "puppet":
#  ensure => "present",
# }
#}

#node /^(db)\d+$/ {
#  package {
#      'mysql-server':
#          ensure => installed,
#          require => Class['apt']
#  }
#  package {
#    'apache2':
#      ensure => purged,
#      require => Service['apache2'],
#  }
#  service {
#      'apache2':
#          ensure => false,
#          enable => false,
#  }
#}

node /^pi\d+$/{
  include pi
  #include common
  include parts
  include weather
  include bingo
  include cacti
  include gearman
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => false,
    }

#    apt::source { 'bsserver2':
#      location   => 'http://bsserver.home.bs/raspbian',
#      repos      => 'main', # restricted universe multiverse',
#      #key        => '4BD6EC30',
#      #key_server => 'pgp.mit.edu',
#    }
}

#node /^(*.web|ddwrt)\d+$/ {
node /^(.*web)\d.*$/ {
  include common
  include parts
  include bingo
  include cacti
  include weather 
  class { 
  'apt': 
    purge_sources_list   => true,
    purge_sources_list_d => true,
  }
  apt::source { 'bsserver':
    location   => 'http://bsserver.home.bs/ubuntu',
    repos      => 'main restricted universe multiverse',
    #key        => '4BD6EC30',
    #key_server => 'pgp.mit.edu',
  }
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
#$dbserver = '192.168.1.99'
}
node /^bs-test$/ {
  include trusty 
  class { 
  'apt': 
    purge_sources_list   => true,
    purge_sources_list_d => true,
  }
#  apt::source { 'bsserver':
#    location   => 'http://bsserver.home.bs/ubuntu',
#    repos      => 'main restricted universe multiverse',
#    #key        => '4BD6EC30',
#    #key_server => 'pgp.mit.edu',
#  }
}
node /^bsweb$/ {
  include common
  include parts
  include bingo
  include cacti
  include weather 
  class { 
  'apt': 
    purge_sources_list   => true,
    purge_sources_list_d => true,
  }
  apt::source { 'bsserver':
    location   => 'http://bsserver.home.bs/ubuntu',
    repos      => 'main restricted universe multiverse',
    #key        => '4BD6EC30',
    #key_server => 'pgp.mit.edu',
  }
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
#$dbserver = '192.168.1.99'
}
  
node /^(web|db|vagrant)\d+$/ {
  include common
  include parts
  include bingo
  include cacti
  include weather 
class { 'snmp':
  agentaddress => [ 'udp:161', ],
  ro_community => 'bs',
  ro_network   => '192.168.1.0/32',
  contact      => 'root@yourdomain.org',
  location     => 'My House',
  views       => [ 'systemview included .1', ],
  install_client => true,
  snmp_config    => [ 'defVersion 2c', 'defCommunity bs', 'mibdirs +/usr/local/share/snmp/mibs', ],
  require => Class['apt'],
  #require  => Exec['apt-get update'],
}

}
#node 'db1.home.bs', 'db2.home.bs' {
#  class{ 'cassandra':
#    cluster_name => 'bsCassandra',
#    seeds        => [ '192.168.1.170', '192.168.1.171' ],
#  }
#}

#exec { "apt-get update":
#    command => "/usr/bin/apt-get update",
#    #onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
#}


node /^gm\d+$/{
  include common
  #include parts
  #include weather
  #include bingo
  #include cacti
  include gearman
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }
}

node /^gmjob\d+$/{
  include common
  include gearman
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }
}

node /^python\d+$/{
  include common
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }
}
node /^docker\d+$/{
  include common
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }
}
node /^cassandra\d+$/{
  include trusty 
  class {
    'apt': 
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }
}
