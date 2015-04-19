require "spec_helper"

describe ApplicationHelper do
  context 'icon helper' do
    subject { helper.icon('search') }

    it { should eq('<span class="glyphicon glyphicon-search" aria-hidden="true"></span>') }
  end
end
