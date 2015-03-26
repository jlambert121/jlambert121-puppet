require 'spec_helper'

describe 'puppet::server::service', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

  describe 'defaults' do
    let(:pre_condition) { 'class {"puppet":}' }
    it { should_not contain_service('puppetserver') }
  end

  describe 'with server' do
    let(:pre_condition) { 'class { "puppet": server => true }' }
    it { should contain_service('puppetserver').with(:ensure => 'running', :enable => true) }
  end

end
