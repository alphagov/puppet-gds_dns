require 'spec_helper'

describe 'gds_dns::client' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_class('dnsmasq::client') }
end
