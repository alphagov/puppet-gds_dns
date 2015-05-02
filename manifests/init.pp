# = Class: gds_dns
#
# GDS internal module for managing DNS.
#
# Pulls in the following modules:
#   - dnsmasq
#   - resolvconf
#
# Use the dnsmasq::upstreams::upstream_servers hiera key to inject
# upstream DNS servers for a host.
#
# == Parameters:
#
# [*server*]
#   Whether the node will be a DNS server or not. If true, `gds_dns::server`
#   is included. If false, `gds_dns::client` is included.
#   Default: false
#
# [*upstream_servers*]
#   An ordered array of upstream DNS servers to proxy.
#   Default: []
#
# [*options*]
#   Default config options for the server.
#   Default:
#     options:
#       no-negcache: ''
#       strict-order: ''
#       cache-size: '15000'
#       no-hosts: ''

class gds_dns(
  $server           = false,
  $upstream_servers = [],
  $options          = $gds_dns::params::default_options,
) inherits gds_dns::params {

  class { '::resolvconf':
    use_local => true,
  }

  class {'dnsmasq':
    upstream_servers => $upstream_servers,
  }

  dnsmasq::conf { 'defaults':
    ensure  => present,
    content => template('gds_dns/dnsmasq/config_options.conf.erb'),
  }

  $sub_class = $server ? {
    true    => 'server',
    default => 'client',
  }

  class { "gds_dns::${sub_class}":
    before => Class['resolvconf'],
  }

}
