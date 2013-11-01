# = Class: gds_dns
#
# GDS internal module for managing DNS.
#
# Pulls in the following modules:
#   - dnsmasq
#   - hosts
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
class gds_dns(
  $server = false
) {

  include ::hosts

  class { '::resolvconf':
    use_local => true,
  }

  include dnsmasq::upstreams

  dnsmasq::conf { 'defaults':
    ensure => present,
    source => 'puppet:///modules/gds_dns/dnsmasq/defaults.conf',
  }

  $sub_class = $server ? {
    true    => 'server',
    default => 'client',
  }

  class { "gds_dns::${sub_class}":
    before  => Class['resolvconf'],
    require => Class['hosts'],
  }

}
