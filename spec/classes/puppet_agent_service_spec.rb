require 'spec_helper'

describe 'puppet::agent::service', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin' } }

  describe 'defaults' do
    let(:pre_condition) { 'include puppet' }
    it { should contain_cron('puppet').with(:ensure => 'present') }
    it { should contain_service('puppet').with(:ensure => 'stopped', :enable => false) }
  end

  describe 'service' do
    let(:pre_condition) { 'class {"::puppet": runmode => "service"}' }
    it { should contain_cron('puppet').with(:ensure => 'absent') }
    it { should contain_service('puppet').with(:ensure => 'running', :enable => true) }
  end

  describe 'none' do
    let(:pre_condition) { 'class{"::puppet": runmode => "none"}' }
    it { should contain_cron('puppet').with(:ensure => 'absent') }
    it { should contain_service('puppet').with(:ensure => 'stopped', :enable => false) }
  end

end
