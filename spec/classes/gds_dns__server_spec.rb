require 'spec_helper'

describe 'gds_dns::server' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_class('dnsmasq::server').with_require('Class[Gds_dns]') }
end
