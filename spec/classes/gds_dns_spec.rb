require 'spec_helper'

describe 'gds_dns' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'includes' do
    it { should contain_class('resolvconf').with_use_local(true) }
    it { should contain_class('dnsmasq') }
  end

  context 'dnsmasq defaults' do
    it { should contain_dnsmasq__conf('defaults') }
  end

  context 'server param' do
    context 'server false' do
      it {
        should contain_class('gds_dns::client').with(
          :before  => 'Class[Resolvconf]',
        )
      }
    end

    context 'server true' do
      let(:params) {{
        :server => true,
      }}

      it {
        should contain_class('gds_dns::server').with(
          :before  => 'Class[Resolvconf]',
        )
      }
    end
  end
end
