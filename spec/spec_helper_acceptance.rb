require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    install_puppet
  end

  hosts.each do |host|
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Install module and dependencies
      copy_module_to(host, :source => proj_root, :module_name => 'puppet', :target_module_path => '/etc/puppet/environments/production/modules')
      hosts.each do |host|
        # Set up envnrionments dir
        on host, "mkdir -p /etc/puppet/environments/production/modules"
        on host, "chown -R puppet:puppet /etc/puppet/environments"

        # For puppet 3.x need to point default modules dir to environment modules dir
        on host, "rm -rf /etc/puppet/modules"
        on host, "ln -s /etc/puppet/environments/production/modules /etc/puppet/modules"

        on host, puppet('module', 'install', '--target-dir', '/etc/puppet/environments/production/modules', 'puppetlabs-concat'), { :acceptable_exit_codes => [0,1] }
        on host, puppet('module', 'install', '--target-dir', '/etc/puppet/environments/production/modules', 'puppetlabs-firewall'), { :acceptable_exit_codes => [0,1] }
        on host, puppet('module', 'install', '--target-dir', '/etc/puppet/environments/production/modules', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }

        # Puppetserver listens to ipv6 undefined address if loaded, disable ipv6 for tests
        # After SERVER-248 is completed, test IPV4 and IPV6
        # https://tickets.puppetlabs.com/browse/SERVER-248
        shell("echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6")
        shell("echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6")
      end
    end
  end
end
