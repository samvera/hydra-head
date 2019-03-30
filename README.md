# Hydra-Head

Code: [![Version](https://badge.fury.io/rb/hydra-head.png)](http://badge.fury.io/rb/hydra-head)
[![Build Status](https://circleci.com/gh/samvera/hydra-head.svg?style=svg)](https://circleci.com/gh/samvera/hydra-head)
[![Coverage Status](https://coveralls.io/repos/github/samvera/hydra-head/badge.svg?branch=master)](https://coveralls.io/github/samvera/hydra-head?branch=master)

Docs: [![Contribution Guidelines](http://img.shields.io/badge/CONTRIBUTING-Guidelines-blue.svg)](./CONTRIBUTING.md)
[![Apache 2.0 License](http://img.shields.io/badge/APACHE2-license-blue.svg)](./LICENSE)

Jump in: [![Slack Status](http://slack.samvera.org/badge.svg)](http://slack.samvera.org/)


# What is Hydra-Head?

Hydra-Head is a Ruby-on-Rails gem containing the core code for a web
application using the full stack of Samvera building blocks.

## Product Owner & Maintenance

hydra-head is a Core Component of the Samvera community. The documentation for
what this means can be found
[here](http://samvera.github.io/core_components.html#requirements-for-a-core-component).

### Product Owner

[cjcolvar](https://github.com/cjcolvar)

# Help

The Samvera community is here to help. Please see our [support guide](./.github/SUPPORT.md).

See the Github wikis for information targeted to developers:
<http://github.com/samvera/hydra-head/wiki>

See the Duraspace Hydra wikis for information at the architecture level:
<http://wiki.duraspace.org/display/samvera/>

Additionally, new adopters and potential adopters may find the pages
here useful: <http://samvera.org/>

Further questions? [Get in touch](https://wiki.duraspace.org/pages/viewpage.action?pageId=87460391)

## Installation/Setup

### Installation Prerequisites

See the [Installation Prerequisites](http://github.com/samvera/hydra-head/wiki/Installation-Prerequisites) wiki page.

Ruby 2.1.0+ is required by Hydra-Head release 10+; RVM is strongly suggested.

### Install Rails

    gem install 'rails' --version '~>5.1.0'

### Generate a new rails application:

    rails new my_hydra_head
    cd my_hydra_head

### Install Dependencies

First, add them to the [Gemfile](http://gembundler.com/gemfile.html) of
your application. The new rails application you just generated will have
generated a Gemfile; add blacklight and hydra-head as below:

      source 'https://rubygems.org'

      gem 'rails'
      gem 'blacklight'
      gem 'hydra-head', '~> 10.0'

To install all of the dependencies, run:

    bundle install


### Run the generators and migrations:

Run the blacklight generator

    rails g blacklight:install --devise

Run the hydra-head generator

    rails g hydra:head -f

Run the database migrations

    rake db:migrate

### You're done.

Congratulations. You've set up the code for your Hydra Head.

Read [Tools for Developing and Testing your
Application](http://github.com/samvera/hydra-head/wiki/Tools-for-Developing-and-Testing-your-Application),
then read [How to Get
Started](http://github.com/samvera/hydra-head/wiki/How-to-Get-Started)
to get a sense of what you can do with your Hydra Head.

## Modifying and Testing the hydra-head Gem

For those developers who want to or need to work on the hydra-head gem
itself, see the [Instructions for
Contributors](http://github.com/samvera/hydra-head/wiki/For-Contributors)

# Acknowledgments

This software has been developed by and is brought to you by the Samvera community.  Learn more at the
[Samvera website](http://samvera.org/).

![Samvera Logo](https://wiki.duraspace.org/download/thumbnails/87459292/samvera-fall-font2-200w.png?version=1&modificationDate=1498550535816&api=v2)
