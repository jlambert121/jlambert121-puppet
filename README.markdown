#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
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

[Changelog](https://github.com/evenup/evenup-puppet/CHANGELOG)
[Contributors](https://github.com/evenup/evenup-puppet/graphs/contributors)
