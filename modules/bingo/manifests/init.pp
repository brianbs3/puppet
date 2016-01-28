class bingo{

  $dbserver = '192.168.1.99'
  file { 

    'bingo_web':
      path    => "/var/www/bingo",
      ensure  => "directory",
      owner   => bs,
      group   => bs,
      mode    => "0755",
      require => Package['apache2'];
  
#    'bingo_application':
#      path    => "/var/www/bingo/application",
#      ensure  => "directory",
#      owner   => bs,
#      group   => bs,
#      mode    => "0777",
#      require => Exec['bingo_git_clone'];
#  
#    'bingo_log':
#      path    => "/var/www/bingo/application/logs",
#      ensure  => "directory",
#      owner   => bs,
#      group   => bs,
#      mode    => "0777",
#      require => File['bingo_application'];
  
  }

  exec {
    'bingo_git_clone':
      command => '/usr/bin/git clone -q git@bsserver.home.bs:bs/bingo.git /var/www/bingo',
#      cwd => '/var/www/bingo',
      user  => 'bs',
      unless => '/usr/bin/test -d /var/www/bingo/.git',
      require => [File['web', '/home/bs/.ssh/id_rsa', '/etc/ssh/ssh_config'], Package['git']];

    'bingo_git_update':
      command => '/usr/bin/git pull',
      require => [ Package['git'], File['/var/www/bingo'], Exec['git_clone'], File['/home/bs/.ssh/id_rsa'], File['git_update_check'] ],
      cwd => '/var/www/bingo',
      user => 'bs',
      unless => '/usr/local/bin/git_update_check';

    

    
  }
}
