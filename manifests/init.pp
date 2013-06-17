# = Class: gds_dns
#
# GDS internal module for managing DNS.
#
# Pulls in the following modules:
#   - hosts
#   - resolvconf
#
class gds_dns {
  include ::hosts
  include ::resolvconf
}
