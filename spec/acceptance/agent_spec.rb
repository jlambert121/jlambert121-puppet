require 'spec_helper_acceptance'

describe 'puppet::agent classes' do

  context 'agent' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': agent => true }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('puppet-agent') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/puppetlabs/puppet/puppet.conf') do
      it { is_expected.to be_file }
    end

  end # agent

  context 'cron runmode' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': agent => true, runmode => 'cron' }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe service('puppet') do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end

    describe cron do
      it { should have_entry '23,53 * * * * /opt/puppetlabs/bin/puppet agent --onetime --no-daemonize' }
    end
  end # cron runmode

  context 'service runmode' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': agent => true, runmode => 'service' }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe service('puppet') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe cron do
      it { should_not have_entry '23,53 * * * * /opt/puppetlabs/bin/puppet agent --onetime --no-daemonize' }
    end

  end # service runmode

  context 'none runmode' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'puppet': agent => true, runmode => 'none' }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe service('puppet') do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end

    describe cron do
      it { should_not have_entry '23,53 * * * * /opt/puppetlabs/bin/puppet agent --onetime --no-daemonize' }
    end

  end # none runmode

end
