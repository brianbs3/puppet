package {
    'git':
        ensure => installed
}

file { "/tmp/mytest.txt":
    mode => 770,
    owner => bs,
    group => root,
    source => "puppet:///common/test.txt"
}
