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
class gds_dns::server(
  $hosts = '',
  $cnames = {},
  $aliases = {}
) {
  validate_hash($cnames)
  validate_hash($aliases)

  dnsmasq::conf { 'server':
    ensure => present,
    source => 'puppet:///modules/gds_dns/dnsmasq/server.conf',
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
