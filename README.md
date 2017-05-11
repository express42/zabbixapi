# Ruby Zabbix Api Module

[![Gem Version](http://img.shields.io/gem/v/zabbixapi.svg)][gem]
[![Build Status](http://img.shields.io/travis/express42/zabbixapi.svg)][travis]

[gem]: https://rubygems.org/gems/zabbixapi
[travis]: https://travis-ci.org/express42/zabbixapi

Simple and lightweight ruby module for working with [Zabbix][Zabbix] via the [Zabbix API][Zabbix API]

## Installation
    gem install zabbixapi

## Documentation
[http://rdoc.info/gems/zabbixapi][documentation]

[documentation]: http://rdoc.info/gems/zabbixapi

## Examples
[https://github.com/express42/zabbixapi/tree/master/examples][examples]

[examples]: https://github.com/express42/zabbixapi/tree/master/examples

## Version Policy
We support only two last versions of zabbix (3.0 and 3.2), so you should consider zabbixapi 0.6.x, 2.0.x, 2.2.x, and 2.4.x deprecated.

* Zabbix 1.8.2 (api version 1.2) | zabbixapi 0.6.x | [branch zabbix1.8](https://github.com/express42/zabbixapi/tree/zabbix1.8)
* Zabbix 1.8.9 (api version 1.3) | zabbixapi 0.6.x | [branch zabbix1.8](https://github.com/express42/zabbixapi/tree/zabbix1.8)
* Zabbix 2.0.x (api version 1.4 -> 2.0.10) | zabbixapi 2.0.x | [branch zabbix2.0](https://github.com/express42/zabbixapi/tree/zabbix2.0)
* Zabbix 2.2.x (api version 2.2.x) | zabbixapi 2.2.x | [branch zabbix2.2](https://github.com/express42/zabbixapi/tree/zabbix2.2)
* Zabbix 2.4.x (api version 2.2.x) | zabbixapi 2.4.x | [branch zabbix2.4](https://github.com/express42/zabbixapi/tree/zabbix2.4)
* Zabbix 3.0.x (api version 3.0.x) | zabbixapi 3.0.x | [master](https://github.com/express42/zabbixapi/)
* Zabbix 3.2.x (api version 3.2.x) | zabbixapi 3.0.x | [master](https://github.com/express42/zabbixapi/)

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
versions:

* Ruby 2.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3
* Ruby 2.4
* JRuby 9.1.6.0

If something doesn't work on one of these versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby versions,
however support will only be provided for the versions listed above.

If you would like this library to support another Ruby version or
implementation, you may volunteer to be a maintainer. Being a maintainer
entails making sure all tests run and pass on that implementation. When
something breaks on your implementation, you will be responsible for providing
patches in a timely fashion. If critical issues for a particular implementation
exist at the time of a major release, support for that Ruby version may be
dropped.

## Dependencies

* net/http
* net/https
* json

## Contributing

* Fork the project.
* Make your feature addition or bug fix, write tests, write documentation/examples.
* Commit, do not mess with rakefile, version.
* Make a pull request.

## Zabbix documentation

* [Zabbix Project Homepage][Zabbix]
* [Zabbix API docs][Zabbix API]

[Zabbix]: https://www.zabbix.com
[Zabbix API]: https://www.zabbix.com/documentation/3.2/manual/api

## Copyright
Copyright (c) 2015-2017 Express 42

See [LICENSE][] for details.

[license]: LICENSE.md