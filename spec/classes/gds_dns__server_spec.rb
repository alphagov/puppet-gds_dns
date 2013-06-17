require 'spec_helper'

describe 'gds_dns::server' do
  let(:pre_condition) { <<EOS
# Mock dependencies.
class dnsmasq::server {}
EOS
  }

  it { should contain_class('dnsmasq::server').with_require('Class[Gds_dns]') }
end
