# = Class: gds_dns::client
#
# Wrapper for dnsmasq::client.
#
class gds_dns::client {
  class { 'dnsmasq::client': }
}
