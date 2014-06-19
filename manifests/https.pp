define pound::https (
  $cert,
  $address          = $::ipaddress,
  $port             = '443',
  $backend          = { '127.0.0.1' => '80' },
  $ensure           = 'present',
  $target           = '/etc/pound.conf',
  $custom_template  = undef,
  $ciphers          = 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;',
  $client_cert      = undef,
) { 
  
  if $custom_template { 
    $content = template($custom_template)
  } else {
    # This template uses $cert, $address, $port, $backend, $ciphers
    $content = template("${module_name}/https.erb")
  }
    
  concat::fragment { "https_server-${title}":
    order   => "20-${title}",
    ensure  => $ensure,
    target  => $target,
    content => $content,
  }
}
