# = Class: gds_dns::server
#
# Wrapper for dnsmasq::server.
#
class gds_dns::server {
  class { '::dnsmasq::server':
    require => Class['gds_dns'],
  }
}
