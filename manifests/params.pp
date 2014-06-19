class pound::params {

  $package_ensure = 'present'
  $service_ensure = 'running'
  $service_manage = true
  $user           = 'nobody'
  $group          = 'nogroup'

  case $::osfamily { 
    'RedHat': { 
      $package_name = 'Pound' 
      $config_name  = '/etc/pound.conf'
    }

    default: { 
      fail("${::osfamily} not supported.") 
    }
  }
}
