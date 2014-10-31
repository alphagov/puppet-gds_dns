# = Class: gds_dns::server
#
# Configure dnsmasq as an authoritative and caching server.
#
# == Parameters:
#
# [*hosts*]
#   A multi-line string of hosts(5) entries which will be passed to
#   dnsmasq's `addn-hosts` option.
#   Default: ''
#
# [*cnames*]
#   A hash of `{source => destination}` addresses to create CNAME records
#   from.
#   Default: {}
#
# [*aliases*]
#   A hash of `{source => destination}` addresses to create split-horizon
#   views of external IP addresses.
#   Default: {}
#
# [*options*]
#   Hash of server config options to include in the DNSmasq configuration for authoritative servers.
#   Default:
#     server_options:
#       domain-needed: ''
#       bogus-priv: ''
#


class gds_dns::server(
  $hosts   = '',
  $cnames  = {},
  $aliases = {},
  $options = $gds_dns::params::server_options,
) inherits gds_dns::params {

  validate_hash($cnames)
  validate_hash($aliases)

  dnsmasq::conf { 'server':
    ensure  => present,
    content => template('gds_dns/dnsmasq/config_options.conf.erb'),
  }

  file { '/etc/hosts.dnsmasq':
    ensure  => present,
    content => $hosts,
    notify  => Class['dnsmasq::reload'],
  }

  dnsmasq::conf { 'server_hosts':
    ensure  => present,
    content => template('gds_dns/dnsmasq/server_hosts.conf.erb'),
    require => File['/etc/hosts.dnsmasq'],
  }
}
