require 'spec_helper'

describe 'nginx' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "nginx class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('nginx::params') }
	end
      end
    end
  end
  context 'unsupported operating systems' do
    let(:facts) do
      { :operatingsystem => 'Windows'}
    end
    it do
      expect {
       catalogue
      }.to raise_error(Puppet::Error, /supported by nginx/)
    end
  end
end
