require 'spec_helper'

describe 'puppet::server::install', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

  describe 'default' do
    let(:pre_condition) { 'class {"::puppet": server => true}' }
    it { should contain_package('puppetserver').with(:ensure => 'latest') }
    it { should contain_file('/etc/puppetlabs/code/environments') }
  end

  describe 'set version' do
    let(:pre_condition) { 'class {"::puppet": server => true, server_version => "0.4.0"}' }
    it { should contain_package('puppetserver').with(:ensure => '0.4.0') }
  end

  describe 'server == false' do
    let(:pre_condition) { 'class {"::puppet": server => false }' }
    it { should contain_package('puppetserver').with(:ensure => 'absent') }
    it { should contain_package('puppetdb-terminus').with(:ensure => 'absent') }
  end

  describe 'puppetdb' do
    context 'default' do
      let(:pre_condition) { 'class {"::puppet": server => true}' }
      it { should contain_package('puppetdb-terminus').with(:ensure => 'absent') }
    end

    context 'installed' do
      let(:pre_condition) { 'class {"::puppet": server => true, puppetdb => true, puppetdb_server => "db.example.com"}' }
      it { should contain_package('puppetdb-terminus').with(:ensure => 'latest') }
    end

    context 'with version' do
      let(:pre_condition) { 'class {"::puppet": server => true, puppetdb => true, puppetdb_server => "db.example.com", puppetdb_version => "2.2.3"}' }
      it { should contain_package('puppetdb-terminus').with(:ensure => '2.2.3') }
    end
  end

end
