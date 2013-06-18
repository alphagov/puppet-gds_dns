require 'spec_helper'

describe 'gds_dns::client' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_dnsmasq__conf('client') }
end
