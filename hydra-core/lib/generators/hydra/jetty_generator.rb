# -*- encoding : utf-8 -*-
require 'jettywrapper'

module Hydra
  class Jetty < Rails::Generators::Base

    desc """
Installs a jetty container with a solr and fedora installed in it.

Requires system('unzip... ') to work, probably won't work on Windows.

"""

    class_option :version, type: :string, desc: 'The version of hydra-jetty to install'

    def download_jetty
      Jettywrapper.hydra_jetty_version = options[:version] unless options[:version].nil?
      Jettywrapper.unzip
    end


  end
end

