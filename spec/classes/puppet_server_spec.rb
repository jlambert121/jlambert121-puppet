require 'spec_helper'

describe 'puppet::server', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin' } }
  let(:pre_condition) { 'include puppet' }

  it { should create_class('puppet::server') }
  it { should contain_class('puppet::server::install') }
  it { should contain_class('puppet::server::config') }
  it { should contain_class('puppet::server::service') }

end
