require 'spec_helper'

describe Hydra::AccessControls::Permission::ModeMap do
  subject { described_class.new(modes).resulting_mode }

  describe "discover access" do
  	let(:modes) { [Hydra::AccessControls::Mode.new(Hydra::ACL.Discover)] }
  	its(:id) { is_expected.to eq(Hydra::ACL.Discover) }
  end

  describe "read access" do
  	let(:modes) { [Hydra::AccessControls::Mode.new(ACL.Read)] }
  	its(:id) { is_expected.to eq(ACL.Read) }
  end

  describe "edit access" do
  	let(:modes) { [Hydra::AccessControls::Mode.new(ACL.Write)] }
  	its(:id) { is_expected.to eq(ACL.Write) }
  end

  describe "no access specified" do
  	let(:modes) { [] }
  	it { is_expected.to be_nil }
  end

  describe "a non-Hydra access level" do
  	let(:custom_access) { ::RDF::URI("http://my.custom.access/Level1") }
  	let(:modes) { [Hydra::AccessControls::Mode.new(custom_access)] }
  	it { is_expected.to be_nil }
  end
end
