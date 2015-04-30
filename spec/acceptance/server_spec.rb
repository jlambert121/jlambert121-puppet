require 'spec_helper_acceptance'

describe 'puppet::server classes' do

  context 'server' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': agent => false, server => true, server_java_opts => '-Xms512m -Xmx512m -XX:MaxPermSize=256m'}
      EOS

      # Ensure puppet ssl dir is clean
      shell("rm -rf /etc/puppetlabs/puppet/ssl")

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      # Ensure there's enough time to generate SSL certs on first run
      shell("sleep 120")
      apply_manifest(pp, :catch_changes  => true)
      #Ensure puppetserver has enough time to start
      shell("sleep 60")
    end

    describe package('puppetserver') do
      it { is_expected.to be_installed }
    end

    describe service('puppetserver') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8140) do
      it { should be_listening.with('tcp') }
    end

  end # server

  context 'without server' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': server => false}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
      # Give it a chance to shutdown
      shell('sleep 20')
    end

    describe package('puppetserver') do
      it { is_expected.not_to be_installed }
    end

    describe service('puppetserver') do
      it { is_expected.not_to be_running }
    end
  end #without server

end
