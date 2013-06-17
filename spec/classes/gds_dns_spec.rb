require 'spec_helper'

describe 'gds_dns' do
  let(:pre_condition) { <<EOS
# Mock out dependencies
class hosts {}
class resolvconf {}
EOS
  }

  context 'includes' do
    it { should include_class('hosts') }
    it { should include_class('resolvconf') }
  end
end
