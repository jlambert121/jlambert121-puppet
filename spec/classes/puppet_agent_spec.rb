require 'spec_helper'

describe 'puppet::agent', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }
  let(:pre_condition) { 'include puppet' }

  it { should create_class('puppet::agent') }
  it { should contain_class('puppet::agent::config') }
  it { should contain_class('puppet::agent::service') }

end
