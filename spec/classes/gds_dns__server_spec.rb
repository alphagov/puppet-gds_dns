require 'spec_helper'

describe 'gds_dns::server' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'server config' do
    it { should contain_dnsmasq__conf('server') }
  end

  context 'default params' do
    it {
      should contain_file('/etc/hosts.dnsmasq').with(
        :ensure  => 'present',
        :notify  => 'Class[Dnsmasq::Reload]',
        :content => ''
      )
    }

    it {
      should contain_dnsmasq__conf('server_hosts').with(
        :ensure  => 'present',
        :require => 'File[/etc/hosts.dnsmasq]'
      )
    }

    it { should_not contain_dnsmasq__conf('server_hosts').with_content(/^(cname|alias)=/) }
  end

  context 'hosts param' do
    let(:params) {{
      :hosts => "1.1.1.1 foo.example.com foo\n2.2.2.2 bar.example.com bar\n",
    }}

    it {
      should contain_file('/etc/hosts.dnsmasq').with(
        :content => <<EOS
1.1.1.1 foo.example.com foo
2.2.2.2 bar.example.com bar
EOS
      )
    }
  end

  context 'cnames param' do
    let(:params) {{
      :cnames => {
        '1.1.1.1' => '2.2.2.2',
        '3.3.3.3' => '4.4.4.4',
      },
    }}

    it {
      should contain_dnsmasq__conf('server_hosts').with(
        :content => /^cname=1.1.1.1,2.2.2.2\ncname=3.3.3.3,4.4.4.4$/
      )
    }
  end

  context 'aliases param' do
    let(:params) {{
      :aliases => {
        '1.1.1.1' => '2.2.2.2',
        '3.3.3.3' => '4.4.4.4',
      },
    }}

    it {
      should contain_dnsmasq__conf('server_hosts').with(
        :content => /^alias=1.1.1.1,2.2.2.2\nalias=3.3.3.3,4.4.4.4$/
      )
    }
  end
end
