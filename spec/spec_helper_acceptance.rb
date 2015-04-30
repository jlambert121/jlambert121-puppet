require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    on host, "yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm"
    on host, "yum install -y puppet-agent"
    # Ensure `puppet` is in the path
    on host, "ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet"
#    on host "curl -O http://apt.puppetlabs.com/puppetlabs-release-pc1-wheezy.deb ; dpkg -i puppetlabs-release-pc1-wheezy.deb"
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
      copy_module_to(host, :source => proj_root, :module_name => 'puppet', :target_module_path => '/etc/puppetlabs/code/environments/production/modules')
      hosts.each do |host|
        on host, puppet('module', 'install', '--target-dir', '/etc/puppetlabs/code/environments/production/modules', 'puppetlabs-concat'), { :acceptable_exit_codes => [0,1] }
        on host, puppet('module', 'install', '--target-dir', '/etc/puppetlabs/code/environments/production/modules', 'puppetlabs-firewall'), { :acceptable_exit_codes => [0,1] }
        on host, puppet('module', 'install', '--target-dir', '/etc/puppetlabs/code/environments/production/modules', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }

        # needed for puppetlabs/concat
        on host, "yum -y install ruby"

        # puppet 4.0.0 is broken with obseleted packages
        # https://tickets.puppetlabs.com/browse/PUP-4497
        on host, "yum -y update"

        # Puppetserver listens to ipv6 undefined address if loaded, disable ipv6 for tests
        # After SERVER-248 is completed, test IPV4 and IPV6
        # https://tickets.puppetlabs.com/browse/SERVER-248
        shell("echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6")
        shell("echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6")
      end
    end
  end
end
