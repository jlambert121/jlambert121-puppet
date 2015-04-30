require 'spec_helper'

describe 'puppet::server::config', :type => :class do

  describe 'defaults' do
    let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }
    let(:pre_condition) { 'class { "puppet": }' }

    it { should_not contain_concat__fragment('puppet_master') }
    it { should contain_file('/etc/puppetlabs/puppetserver/bootstrap.cfg').with(:ensure => 'absent') }
    it { should contain_file('/etc/puppetlabs/puppetserver/logback.xml').with(:ensure => 'absent') }
    it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/ca.conf').with(:ensure => 'absent') }
    it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/global.conf').with(:ensure => 'absent') }
    it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf').with(:ensure => 'absent') }
    it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/webserver.conf').with(:ensure => 'absent') }

    context 'redhat' do
      let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }
      let(:pre_condition) { 'class { "puppet": }' }
      it { should contain_file('/etc/sysconfig/puppetserver').with(:ensure => 'absent') }
    end

    context 'debian' do
      let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'Debian', :id => '0', :path => '/bin', :kernel => 'Linux' } }
      let(:pre_condition) { 'class { "puppet": }' }
      it { should contain_file('/etc/default/puppetserver').with(:ensure => 'absent') }
    end
  end

  describe 'with server' do
    let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'RedHat', :operatingsystemmajrelease => '7', :id => '0', :path => '/bin', :kernel => 'Linux' } }

    context 'all oses' do
      let(:pre_condition) { 'class { "puppet": server => true}' }

      it { should contain_file('/var/log/puppetserver').with(:ensure => 'directory') }
      it { should contain_concat__fragment('puppet_master').with(:content => /ca = true/) }
      it { should_not contain_concat__fragment('puppet_master').with(:content => /reports/) }
      it { should_not contain_concat__fragment('puppet_master').with( :content => /dns_alt_names/ ) }
      it { should_not contain_concat__fragment('puppet_master').with(:content => /storeconfigs/) }
      it { should contain_file('/etc/puppetlabs/puppetserver/bootstrap.cfg').with(:content => /puppetlabs\.services\.ca\.certificate\-authority\-service\/certificate\-authority\-service/) }
      it { should_not contain_file('/etc/puppetlabs/puppetserver/bootstrap.cfg').with(:content => /puppetlabs\.services\.ca\.certificate\-authority\-disabled\-service\/certificate\-authority\-disabled\-service/) }
      it { should contain_file('/etc/puppetlabs/puppetserver/logback.xml').with(:content => /<file>\/var\/log\/puppetserver\/puppetserver\.log<\/file>/) }
      it { should contain_file('/etc/puppetlabs/puppetserver/request-logging.xml') }
      it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/ca.conf') }
      it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/global.conf') }
      it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf') }
      it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/web-routes.conf') }
      it { should contain_file('/etc/puppetlabs/puppetserver/conf.d/webserver.conf') }
      it { should contain_file('/etc/puppetlabs/code/hiera.yaml').with(:ensure => 'absent') }
    end

    context 'redhat' do
      let(:pre_condition) { 'class { "puppet": server => true}' }
      it { should contain_file('/etc/sysconfig/puppetserver') }
    end

    context 'debian' do
      let(:facts) { { :concat_basedir => '/var/lib/puppet/concat', :domain => 'example.com', :osfamily => 'Debian', :id => '0', :path => '/bin', :kernel => 'Linux' } }
      let(:pre_condition) { 'class { "puppet": server => true}' }
      it { should contain_file('/etc/default/puppetserver') }
    end

    context 'set java opts' do
      let(:pre_condition) { 'class { "puppet": server => true, server_java_opts => "blah" }'}
      it { should contain_file('/etc/sysconfig/puppetserver').with(:content => /JAVA_ARGS="blah"/) }
    end

    context 'set disable ca' do
      let(:pre_condition) { 'class { "puppet": server => true, server_ca_enabled => false }'}
      it { should_not contain_file('/etc/puppetlabs/puppetserver/bootstrap.cfg').with(:content => /puppetlabs\.services\.ca\.certificate\-authority\-service\/certificate\-authority\-service/) }
      it { should contain_file('/etc/puppetlabs/puppetserver/bootstrap.cfg').with(:content => /puppetlabs\.services\.ca\.certificate\-authority\-disabled\-service\/certificate\-authority\-disabled\-service/) }
      it { should contain_concat__fragment('puppet_master').with(:content => /ca = false/) }
    end

    context 'with hiera_source' do
      let(:pre_condition) { 'class { "puppet": server => true, hiera_source => "puppet:///data/hiera.yaml" }'}
      it { should contain_file('/etc/puppetlabs/code/hiera.yaml').with(:source => 'puppet:///data/hiera.yaml') }
    end

    context 'with puppetdb' do
      let(:pre_condition) { 'class { "puppet": server => true, puppetdb => true, puppetdb_server => "db.example.com" }'}
      it { should contain_file('/etc/puppetlabs/puppet/routes.yaml') }
      it { should contain_file('/etc/puppetlabs/puppet/puppetdb.conf').with(:content => /db\.example\.com/) }
      it { should contain_concat__fragment('puppet_master').with(:content => /storeconfigs/) }
    end

    context 'with reports' do
      let(:pre_condition) { 'class { "puppet": server => true, server_reports => ["puppetdb", "hipchat"] }'}
      it { should contain_concat__fragment('puppet_master').with(:content => /reports = puppetdb, hipchat/) }
    end

    context 'with dns_alt_names' do
      let(:pre_condition) { 'class { "puppet": server => true, dns_alt_names => ["puppet.example.com"] }'}
      it { should contain_concat__fragment('puppet_master').with(:content => /dns_alt_names = puppet.example.com/) }
    end

  end

end
