#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Agent Configuration](#agent-configuration)
    * [Server Configuration](#server-configuration)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Changelog/Contributors](#changelog-contributors)

## Overview

A puppet module to manage puppet and puppetserver (the closure server, not ruby).  Please see warnings below.

## Module Description

**WARNING**: This module is currently intended for bleeding edge/testing environments only.  It will become stable after the puppet 4.0 release

**WARNING**: This module only supports environment directories and will purge /etc/puppet/modules and /etc/puppet manifests

This is a very opinionated module enforcning currently optional features that will be default or required in puppet 4.  When
puppet 4 nightly packages are available, this module will be updated to use those packages to ensure compatibility with
puppet 4 when it is released.

## Setup

### What puppet affects

* puppet and puppetserver services
* cron entry (if desired) for scheduled puppet runs
* /etc/puppet.conf, /etc/puppetserver/*


### Beginning with puppet

This module can be installed with

```
  puppet module install evenup-puppet
```

## Usage

Basic usage only managing puppet and the puppetmaster at "puppet.${::domain}"

```puppet
    class { 'puppet': }
```

Setting up a puppetserver node (with agent running as daemon)

```puppet
    class { 'puppet':
      runmode => 'service',
      server  => true,
    }
```

###Parameters

#### Agent Configuration

#####`agent`
Boolean.  Whether or not the agent should be installed

Default: true

#####`puppet_version`
String.  Version of the puppet agent to install

Default: latest

#####`ca_server`
String.  Hostname of the CA server to be used by the agent

Default: undef

#####`use_srv_records`
Boolean.  Whether or not to use DNS SRV records

Defaul: false

#####`srv_domain`
String.  Domain to use for DNS SRV records

Default: undef

#####`runmode`
String.  How the puppet agent runs should be scheduled.

Allowed values: cron, service, none

Default: cron

#####`environment`
String.  Environment for this agent

Default: production

#### Server Configuration

#####`server`
Boolean.  Whether or not the server should be installed

Default: false

#####`dns_alt_names`
String.  Alternative DNS names for this server

Default: undef

#####`fileserver_conf`
Hash.  Fileserver mounts to configure

Default: undef

The format of this value is:
```
    {
      mountpoint => {
        parameter => value
      }
    }
```

#####`hiera_source`
String.  Source for hiera.yaml to install.  Will enable hiera lookups on the server

Default: undef

#####`server_puppetdb`
Boolean.  Whether or not puppetdb terminus and route configuration should be installed

Default: false

#####`server_puppetdb_port`
Integer.  Port puppetdb is listening on.

Default: 8081

#####`server_puppetdb_server`
String.  Hostname where puppetdb is running.  Required if puppetdb => true

Default: undef

#####`server_puppetdb_version`
String.  Version of puppetdb-terminus to install.

Default: latest

#####`server_ca_enabled`
Boolean.  Whether or not to enable the CA server

Default: true

#####`server_certname`
String.  Allow overriding certname

Default: undef

#####`server_java_opts`
String.  Java options for puppet server

Default: -Xms2g -Xmx2g -XX:MaxPermSize=256m

#####`server_log_dir`
String.  Location of puppetserver logs

Default: /var/log/puppetserver

#####`server_log_file`
String.  Name of puppetserver logfile

Default:  puppetserver.log

#####`server_reports`
String.  List of reports to enable

Default: undef

#####`server_ruby_paths`
String.  Ruby paths included by the puppetserver

Default: varies by OS

#####`server_version`
String.  Version of puppetserver to install.

Default: latest


## Reference

### Classes

#### Public Classes

* `puppet`: Entry point for configuring the module

#### Private Classes

* `puppet::agent`: Controlls ordering and notfications for agent manipulation
* `puppet::agent::config`: Manages agent configuration
* `puppet::agent::service`: Manages agent service and cron entries
* `puppet::common`: Common packages and settings for agent and server
* `puppet::params`: Default parameters for the puppet class
* `puppet::server`: Controlls ordering and notifications for server manipulation
* `puppet::server::install`: Manages the server packages and paths
* `puppet::server::config`: Manages the server configuration
* `puppet::server::service`: Manages the server service


## Limitations

### General
This module is acceptance tested on CentOS 6.5, CentOS 7.0, Ubuntu 12.04, and Ubuntu 14.04.  Feedback on other platforms/versions would be appreciated

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/evenup/evenup-puppet/CONTRIBUTING.md) for
information on adding and validating tests for PRs.

## Changelog / Contributors

[Changelog](https://github.com/evenup/evenup-puppet/blob/master/CHANGELOG)

[Contributors](https://github.com/evenup/evenup-puppet/graphs/contributors)
