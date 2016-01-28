class cacti{ 
  user {
    'cacti':
      ensure      => present,
      managehome  => true,
      gid => "cacti",
      membership => minimum,
      shell => "/bin/bash",
      require     => Group["cacti"];
  }

  group {
    'cacti':
      ensure => present,
   }
  ssh_authorized_key { 
    'cacti@bsserver':
      name    => "cacti_ssh_key",
      ensure  => present,
      key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDecMyHSEZBcGT678lQsptJ3EGU8LyVyDJLO4le1pO/1rx8eClrqgtvr4h8vji1nBkPXvIVjP1oNPd1NpKGXgOjTGHluPh8KjEZkC7Ir/SWVnIuTqAoPVVg27JUze01ESdV6LRdXNYvzjpYpihkFRMdtV2hm7moJ+DImFdg7xqfj9nggGtI/VDcX+WVd5PhI/RYBQzP+oHJpDPkyopPYaMGObRw14+x30AeYHowZELo8fTjmEc3cwONIZ5v9E8rEaWKiiXlOor4UKG3R/x/Lpv+mfUC8KdTYEAgkasgi9RMcNDjpnDHzbwibX73qcpHjEiN5Ou9veDcEbSfLtJTFBQX",
      type    => "rsa",
      user    => cacti,
      require => User["cacti"],
  }

}
