require 'spec_helper'

describe 'puppet::agent::install', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

  describe 'default' do
    let(:pre_condition) { 'include ::puppet' }

    it { should contain_package('puppet-agent') }
  end

  describe 'set puppet version' do
    let(:pre_condition) { 'class {"::puppet": agent_version => "3.7.3"}' }
    it { should contain_package('puppet-agent').with(:ensure => '3.7.3') }
  end

  describe 'without agent or server' do
    let(:pre_condition) { 'class {"::puppet": agent => false, server => false }' }
    it { should_not contain_package('puppet-agent') }
  end

end
