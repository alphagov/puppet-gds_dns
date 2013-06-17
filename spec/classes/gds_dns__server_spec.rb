require 'spec_helper'

describe 'gds_dns::server' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_class('dnsmasq::server') }
end
