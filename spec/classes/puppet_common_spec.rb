require 'spec_helper'

describe 'puppet::common', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat' } }

  describe 'default' do
    let(:pre_condition) { 'include ::puppet' }

    it { should contain_package('puppet') }
    it { should contain_concat('/etc/puppet/puppet.conf') }
    it { should contain_concat__fragment('puppet_main') }
    it { should_not contain_concat__fragment('puppet_main').with( :content => /ca_server/ ) }
    it { should_not contain_concat__fragment('puppet_main').with( :content => /use_srv_records/ ) }
    it { should contain_file('/etc/puppet/auth.conf') }
  end

  describe 'set puppet version' do
    let(:pre_condition) { 'class {"::puppet": puppet_version => "3.7.3"}' }
    it { should contain_package('puppet').with(:ensure => '3.7.3') }
  end

  describe 'without agent or server' do
    let(:pre_condition) { 'class {"::puppet": agent => false, server => false }' }
    it { should contain_package('puppet').with(:ensure => 'absent') }
  end

  describe 'with ca_server' do
    let(:pre_condition) { 'class {"::puppet": ca_server => "puppet.example.com"}'}

    it { should contain_concat__fragment('puppet_main').with( :content => /ca_server = puppet.example.com/) }
  end

  describe 'with use_srv_records, missing domain' do
    let(:pre_condition) { 'class{"::puppet": use_srv_records => true}'}
    it { should_not contain_concat__fragment('puppet_main').with( :content => /use_srv_records/ ) }
  end

  describe 'with use_srv_records and srv_domain' do
    let(:pre_condition) { 'class{"::puppet": use_srv_records => true, srv_domain => "example.com" }'}
    it { should contain_concat__fragment('puppet_main').with( :content => /use_srv_records = true/ ) }
    it { should contain_concat__fragment('puppet_main').with( :content => /srv_domain = example\.com/ ) }
  end

end
