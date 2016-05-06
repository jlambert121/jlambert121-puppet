# Change Log

## [0.8.2](https://github.com/jlambert121/jlambert121-puppet/tree/0.8.2)

[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.8.1...0.8.2)

**Merged pull requests:**

- update bootstrap.cfg for puppetserver 2.3.0 [\#62](https://github.com/jlambert121/jlambert121-puppet/pull/62) ([jlambert121](https://github.com/jlambert121))
- Update concat dep, fix puppetserver 2.3 and remove deprecated java [\#61](https://github.com/jlambert121/jlambert121-puppet/pull/61) ([supernovae](https://github.com/supernovae))
- fix environment issue + tests [\#57](https://github.com/jlambert121/jlambert121-puppet/pull/57) ([sjoeboo](https://github.com/sjoeboo))
- add webserver.conf ssl cert/path settings + tests [\#53](https://github.com/jlambert121/jlambert121-puppet/pull/53) ([sjoeboo](https://github.com/sjoeboo))

## [0.8.1](https://github.com/jlambert121/jlambert121-puppet/tree/0.8.1) (2016-03-03)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.8.0...0.8.1)

**Closed issues:**

- Move dns\_alt\_names to \[main\] section [\#50](https://github.com/jlambert121/jlambert121-puppet/issues/50)

**Merged pull requests:**

- move dns\_alt\_names up into master, placed by puppet::common [\#51](https://github.com/jlambert121/jlambert121-puppet/pull/51) ([sjoeboo](https://github.com/sjoeboo))

## [0.8.0](https://github.com/jlambert121/jlambert121-puppet/tree/0.8.0) (2016-03-03)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.7.0...0.8.0)

**Closed issues:**

- puppetserver.config.erb file missing USER and GROUP [\#47](https://github.com/jlambert121/jlambert121-puppet/issues/47)
- Unexposed options =\> Raw? [\#34](https://github.com/jlambert121/jlambert121-puppet/issues/34)

**Merged pull requests:**

- Adding USER and GROUP so the service can start on Debian. [\#48](https://github.com/jlambert121/jlambert121-puppet/pull/48) ([mgeggie-uber](https://github.com/mgeggie-uber))
- Added support for use-legacy-auth-conf setting in puppetserver.conf - defaulting to false as per puppet defaults. [\#46](https://github.com/jlambert121/jlambert121-puppet/pull/46) ([greigm](https://github.com/greigm))

## [0.7.0](https://github.com/jlambert121/jlambert121-puppet/tree/0.7.0) (2016-01-30)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.6.0...0.7.0)

**Closed issues:**

- puppet::params::puppetdb does not manage puppetdb-termini as described [\#41](https://github.com/jlambert121/jlambert121-puppet/issues/41)

**Merged pull requests:**

- Manage puppetdb [\#45](https://github.com/jlambert121/jlambert121-puppet/pull/45) ([rnelson0](https://github.com/rnelson0))
- \(GH41\) When puppetdb is false, do not manage puppetdb at all [\#42](https://github.com/jlambert121/jlambert121-puppet/pull/42) ([rnelson0](https://github.com/rnelson0))
- One small bugfix and added the ability to set agent runinterval. [\#40](https://github.com/jlambert121/jlambert121-puppet/pull/40) ([greigm](https://github.com/greigm))

## [0.6.0](https://github.com/jlambert121/jlambert121-puppet/tree/0.6.0) (2015-12-15)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.5.0...0.6.0)

**Closed issues:**

- Please provide the ability to disable hiera.yaml management [\#36](https://github.com/jlambert121/jlambert121-puppet/issues/36)
- bootstrap.cfg template lacks trapperkeeper authorization service line [\#35](https://github.com/jlambert121/jlambert121-puppet/issues/35)

**Merged pull requests:**

- version bump: 0.6.0 [\#39](https://github.com/jlambert121/jlambert121-puppet/pull/39) ([jlambert121](https://github.com/jlambert121))
- add authorization service to bootstrap [\#38](https://github.com/jlambert121/jlambert121-puppet/pull/38) ([jlambert121](https://github.com/jlambert121))
- provide the ability to not manage hiera.yaml [\#37](https://github.com/jlambert121/jlambert121-puppet/pull/37) ([jlambert121](https://github.com/jlambert121))
- Exposed ability to set number of jruby instances and set a sane default. [\#32](https://github.com/jlambert121/jlambert121-puppet/pull/32) ([jbehrends](https://github.com/jbehrends))
- version bump: 0.5.0 [\#31](https://github.com/jlambert121/jlambert121-puppet/pull/31) ([jlambert121](https://github.com/jlambert121))

## [0.5.0](https://github.com/jlambert121/jlambert121-puppet/tree/0.5.0) (2015-10-23)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.3.2...0.5.0)

**Closed issues:**

- Feature Request: Enable ca-proxy similar to passenger or pe-ca-proxy [\#12](https://github.com/jlambert121/jlambert121-puppet/issues/12)

**Merged pull requests:**

- Roidelapluie master [\#30](https://github.com/jlambert121/jlambert121-puppet/pull/30) ([jlambert121](https://github.com/jlambert121))
- bump puppet requirement to \>= 4.2.0 [\#29](https://github.com/jlambert121/jlambert121-puppet/pull/29) ([jlambert121](https://github.com/jlambert121))
- updating config templates to match what's shipped with puppetserver-2.1.1 \(v4.2\) [\#28](https://github.com/jlambert121/jlambert121-puppet/pull/28) ([jbehrends](https://github.com/jbehrends))
- Updating to reflect name change of the puppetdb-terminus package to puppetdb-termini [\#27](https://github.com/jlambert121/jlambert121-puppet/pull/27) ([jbehrends](https://github.com/jbehrends))
- correct source url in metadata [\#25](https://github.com/jlambert121/jlambert121-puppet/pull/25) ([jlambert121](https://github.com/jlambert121))
- allow changing environment from agent [\#24](https://github.com/jlambert121/jlambert121-puppet/pull/24) ([jlambert121](https://github.com/jlambert121))
- format todo list properly [\#23](https://github.com/jlambert121/jlambert121-puppet/pull/23) ([mmckinst](https://github.com/mmckinst))
- version bump: 0.3.2 [\#22](https://github.com/jlambert121/jlambert121-puppet/pull/22) ([jlambert121](https://github.com/jlambert121))

## [0.3.2](https://github.com/jlambert121/jlambert121-puppet/tree/0.3.2) (2015-05-02)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.3.1...0.3.2)

**Merged pull requests:**

- fix undefined variable in fileserver template [\#21](https://github.com/jlambert121/jlambert121-puppet/pull/21) ([jlambert121](https://github.com/jlambert121))

## [0.3.1](https://github.com/jlambert121/jlambert121-puppet/tree/0.3.1) (2015-05-01)
[Full Changelog](https://github.com/jlambert121/jlambert121-puppet/compare/0.3.0...0.3.1)

**Merged pull requests:**

- version bump: 0.3.1 [\#20](https://github.com/jlambert121/jlambert121-puppet/pull/20) ([jlambert121](https://github.com/jlambert121))
- fix for puppetserver.conf paths [\#19](https://github.com/jlambert121/jlambert121-puppet/pull/19) ([jlambert121](https://github.com/jlambert121))
- add support for puppet firewall module [\#18](https://github.com/jlambert121/jlambert121-puppet/pull/18) ([jlambert121](https://github.com/jlambert121))
- fix spec test [\#17](https://github.com/jlambert121/jlambert121-puppet/pull/17) ([jlambert121](https://github.com/jlambert121))
- version bump: 0.3.0 [\#16](https://github.com/jlambert121/jlambert121-puppet/pull/16) ([jlambert121](https://github.com/jlambert121))

## [0.3.0](https://github.com/jlambert121/jlambert121-puppet/tree/0.3.0) (2015-05-01)
**Merged pull requests:**

- update puppetserver logs dir [\#15](https://github.com/jlambert121/jlambert121-puppet/pull/15) ([jlambert121](https://github.com/jlambert121))
- documentation update [\#14](https://github.com/jlambert121/jlambert121-puppet/pull/14) ([jlambert121](https://github.com/jlambert121))
- support puppet 4.0 [\#13](https://github.com/jlambert121/jlambert121-puppet/pull/13) ([jlambert121](https://github.com/jlambert121))
- fix spec tests [\#11](https://github.com/jlambert121/jlambert121-puppet/pull/11) ([jlambert121](https://github.com/jlambert121))
- move dns\_alt\_name to main section [\#10](https://github.com/jlambert121/jlambert121-puppet/pull/10) ([jlambert121](https://github.com/jlambert121))
- add lint plugins [\#9](https://github.com/jlambert121/jlambert121-puppet/pull/9) ([jlambert121](https://github.com/jlambert121))
- version bump: 0.2.0 [\#8](https://github.com/jlambert121/jlambert121-puppet/pull/8) ([jlambert121](https://github.com/jlambert121))
- update puppet.conf parameters [\#7](https://github.com/jlambert121/jlambert121-puppet/pull/7) ([jlambert121](https://github.com/jlambert121))
- enable trusted\_node\_data [\#6](https://github.com/jlambert121/jlambert121-puppet/pull/6) ([jlambert121](https://github.com/jlambert121))
- normalize common files [\#5](https://github.com/jlambert121/jlambert121-puppet/pull/5) ([jlambert121](https://github.com/jlambert121))
- fix path to fileserver template [\#4](https://github.com/jlambert121/jlambert121-puppet/pull/4) ([jlambert121](https://github.com/jlambert121))
- fix server::config::fileserver var [\#3](https://github.com/jlambert121/jlambert121-puppet/pull/3) ([jlambert121](https://github.com/jlambert121))
- update templates for puppetserver 1.0 [\#2](https://github.com/jlambert121/jlambert121-puppet/pull/2) ([jlambert121](https://github.com/jlambert121))
- add travis support [\#1](https://github.com/jlambert121/jlambert121-puppet/pull/1) ([jlambert121](https://github.com/jlambert121))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
