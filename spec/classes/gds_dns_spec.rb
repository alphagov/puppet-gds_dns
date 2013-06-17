require 'spec_helper'

describe 'gds_dns' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  context 'includes' do
    it { should include_class('hosts') }
    it { should include_class('resolvconf') }
  end
end
