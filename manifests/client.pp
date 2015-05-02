# = Class: gds_dns::client
#
# Configure dnsmasq to serve as a local forwarder/resolver on loopback.
#
# [*options*]
#   Default config options for the client.
#   Default:
#     client_options:
#       list-address: 127.0.0.1
#       bind-interfaces: ''
#       except-interface: 'lxcbr0'

class gds_dns::client (
  $options = $gds_dns::params::client_options,
) inherits gds_dns::params {

  dnsmasq::conf { 'client':
    ensure  => present,
    content => template('gds_dns/dnsmasq/config_options.conf.erb'),
  }
}
