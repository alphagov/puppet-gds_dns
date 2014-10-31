# = Class: gds_dns::params
#
# Default parameters for DNSmasq.
#
# == Parameters:
#
# [*client_options*]
#   Hash of client config options to include in the DNSmasq configuration for client servers.
#   Use the gds_dns::client::options hiera key to set config entries.
#   Default:
#     client_options:
#       list-address: 127.0.0.1
#       bind-interfaces: ''
#       except-interface: 'lxcbr0'
#
# [*default_options*]
#   Hash of default config options to include in the DNSmasq configuration.
#   Use the gds_dns::options hiera key to set config entries.
#   Default:
#     default_options:
#       no-negcache: ''
#       strict-order: ''
#       cache-size: '15000'
#       no-hosts: ''
#
# [*server_options*]
#   Hash of server config options to include in the DNSmasq configuration for authoritative servers.
#   Use the gds_dns::server::options hiera key to set config entries.
#   Default:
#     server_options:
#       domain-needed: ''
#       bogus-priv: ''
#

class gds_dns::params {

  $client_options = {
    'listen-address'   => '127.0.0.1', # Only bind to loopback for ourselves
    'bind-interfaces'  => '',          # force bind to interfaces vs wildcard listening
    'except-interface' => 'lxcbr0',    # Don't bind to LXC interface (for machines with LXC/docker)
  }

  $default_options = {
    'no-negcache'  => '',      # Never cache NXDOMAIN
    'strict-order' => '',      # Internal should be preferred over external
    'cache-size'   => '15000', # Increase from very small default of 150.
    'no-hosts'     => '',      # Never serve up our own /etc/hosts entries.
  }

  $server_options = {
    'domain-needed' => '', # never forward A or AAAA queries for plain names
    'bogus-priv'    => '', # Don't forward requests for unqualified or RFC1597 addresses.
  }
}
