require 'spec_helper'

describe 'puppet::agent::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

  describe 'defaults' do
    let(:pre_condition) { 'include puppet' }
    it { should create_class('puppet::agent::config') }
    it { should contain_concat__fragment('puppet_agent').with(:content => /environment\s+=\s+production/) }
    it { should contain_concat__fragment('puppet_agent').with(:content => /server\s+=\s+puppet\.example\.com/) }
  end

  describe 'set environment' do
    let(:pre_condition) { 'class{"::puppet": environment => "dev"}' }
    it { should contain_concat__fragment('puppet_agent').with(:content => /environment\s+=\s+dev/) }
  end

  describe 'set puppetmaster' do
    let(:pre_condition) { 'class{"::puppet": puppetmaster => "master.example.com"}'}
    it { should contain_concat__fragment('puppet_agent').with(:content => /server\s+=\s+master.example.com/) }
  end

  describe 'use_srv_records' do
    let(:pre_condition) { 'class{"::puppet": use_srv_records => true}' }
    it { should_not contain_concat__fragment('puppet_agent').with(:content => /server/) }
  end

  describe 'enable on Debian hosts' do
    context 'with agent' do
      let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'Debian', :id => '0', :path => '/bin', :kernel => 'Linux' } }
      let(:pre_condition) { 'include puppet' }
      it { should contain_file('/etc/default/puppet').with(:content => 'START=yes') }
    end

    context 'without agent' do
      let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'Debian', :id => '0', :path => '/bin', :kernel => 'Linux' } }
      let(:pre_condition) { 'class{"::puppet": agent => false}' }
      it { should contain_file('/etc/default/puppet').with(:content => 'START=no') }
    end
  end

end
