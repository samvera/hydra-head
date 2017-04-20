require 'spec_helper'
require 'generators/hydra/head_generator'

describe Hydra::HeadGenerator do
  
  describe "#create_wrapper_configuration" do
    let(:generator) { described_class.new }
    let(:files_to_test) {[
      'config/solr_wrapper_test.yml',
      'config/solr_wrapper_development.yml',
      'config/fcrepo_wrapper_test.yml',
      'config/fcrepo_wrapper_development.yml'
    ]}
    
    before do
      generator.create_wrapper_configuration 
    end

    after do
      files_to_test.each { |file| File.delete(file) }
    end
    
    it "creates config files" do
      files_to_test.each { |file| expect(File.exist?(file)).to( be_truthy, "#{file} was expected to exist" )}
    end
    
  end
  
end