require 'spec_helper'

describe 'puppet::common', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

  describe 'default' do
    let(:pre_condition) { 'include ::puppet' }

    it { should contain_concat('/etc/puppetlabs/puppet/puppet.conf') }
    it { should contain_concat__fragment('puppet_main') }
    it { should_not contain_concat__fragment('puppet_main').with( :content => /ca_server/ ) }
    it { should_not contain_concat__fragment('puppet_main').with( :content => /use_srv_records/ ) }
    it { should_not contain_concat__fragment('puppet_main').with(:content => /certname/) }
    it { should contain_file('/etc/puppetlabs/puppet/auth.conf') }
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

  context 'with server_certname' do
    let(:pre_condition) { 'class { "puppet": server => true, server_certname => "puppet.example.com" }'}
    it { should contain_concat__fragment('puppet_main').with(:content => /certname/) }
  end

  context 'with dns_alt_names' do
    let(:pre_condition) { 'class { "puppet": server => true, dns_alt_names => ["puppet.example.com"] }'}
    it { should contain_concat__fragment('puppet_main').with(:content => /dns_alt_names = puppet.example.com/) }
  end

end
