# = Class: gds_dns::client
#
# Configure dnsmasq to serve as a local forwarder/resolver on loopback.
#
class gds_dns::client {
  dnsmasq::conf { 'client':
    ensure => present,
    source => 'puppet:///modules/gds_dns/dnsmasq/client.conf',
  }
}
