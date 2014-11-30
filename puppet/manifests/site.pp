node default {

  include apt

  $build_packages = ['build-essential', 'python-pip', 'ruby', 'ruby-dev' ] 

  package { $build_packages:
    ensure => installed,
  }
 
  package { 'etcd':
    ensure   => installed,
    provider => gem,
  }

  apt::key { "Georiot":
    key        => "0211F6D4",
    key_source => "http://puppetmaster.georiot.com:8090/binary/keyFile",
  }

  apt::source { 'georiot':
    location     => 'http://puppetmaster.georiot.com:8090/binary',
    include_src  => false,
    release      => "",
    repos        => '/',
  }
 
}
