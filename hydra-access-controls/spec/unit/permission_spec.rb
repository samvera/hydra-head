require 'spec_helper'

describe Hydra::AccessControls::Permission do
  let(:agents) { permission.agent.map(&:rdf_subject) }
  let(:effective_modes) { permission.mode.map(&:rdf_subject) }
  let(:actual_modes) { permission.mode(actual: true).map(&:rdf_subject) }

  describe "an initialized instance" do
    let(:permission) { described_class.new(type: 'person', name: 'bob', access: 'read') }
    context "with read access" do
      it "sets predicates for both read and discover" do
        expect(agents).to contain_exactly ::RDF::URI.new('http://projecthydra.org/ns/auth/person#bob')
        expect(actual_modes).to eq [ACL.Read, Hydra::ACL.Discover]
        expect(effective_modes).to eq [ACL.Read]
      end
    end

    context "with edit access" do
      let(:permission) { described_class.new(type: 'person', name: 'joe', access: 'edit') }
      it "sets predicates for edit, read, and discover" do
        expect(agents).to contain_exactly ::RDF::URI.new('http://projecthydra.org/ns/auth/person#joe')
        expect(actual_modes).to eq [ACL.Write, ACL.Read, Hydra::ACL.Discover]
        expect(effective_modes).to eq [ACL.Write]
      end
    end

    context "with discover access" do
      let(:permission) { described_class.new(type: 'person', name: 'dave', access: 'discover') }
      it "sets predicates for discover" do
        expect(agents).to contain_exactly ::RDF::URI.new('http://projecthydra.org/ns/auth/person#dave')
        expect(actual_modes).to eq [Hydra::ACL.Discover]
        expect(effective_modes).to eq [Hydra::ACL.Discover]
      end
    end

    describe "#to_hash" do
      subject { permission.to_hash }
      it { should eq(type: 'person', name: 'bob', access: 'read') }
    end

    describe "#agent_name" do
      subject { permission.agent_name }
      it { should eq 'bob' }
    end

    describe "#access" do
      subject { permission.access }
      it { should eq 'read' }
    end

    describe "#type" do
      subject { permission.type }
      it { should eq 'person' }
    end

    describe "::type" do
      subject { permission.class.type }
      it { should eq ::RDF::Vocab::ACL.Authorization }
    end
  end

  describe "existing instances with single predicates" do
    let(:permission) { described_class.new(type: 'person', name: 'bob', access: 'read') }
    context "with read access" do
      before do
        permission.mode = [ACL.Read]
        permission.save
      end
      it "interprets a single predicate for read" do
        expect(actual_modes).to eq [ACL.Read]
        expect(effective_modes).to eq [ACL.Read]
      end
    end

    context "with edit access" do
      before do
        permission.mode = [ACL.Write]
        permission.save
      end
      it "interprets a single predicate for write" do
        expect(actual_modes).to eq [ACL.Write]
        expect(effective_modes).to eq [ACL.Write]
      end
    end

    context "with discover access" do
      before do
        permission.mode = [Hydra::ACL.Discover]
        permission.save
      end
      it "interprets a single predicate for discover" do
        expect(actual_modes).to eq [Hydra::ACL.Discover]
        expect(effective_modes).to eq [Hydra::ACL.Discover]
      end
    end
  end

  describe "equality comparison" do
    let(:perm1) { described_class.new(type: 'person', name: 'bob', access: 'read') }
    let(:perm2) { described_class.new(type: 'person', name: 'bob', access: 'read') }
    let(:perm3) { described_class.new(type: 'person', name: 'jane', access: 'read') }

    it "should be equal if all values are equal" do
      expect(perm1).to eq perm2
    end

    it "should be unequal if some values are unequal" do
      expect(perm1).to_not eq perm3
      expect(perm2).to_not eq perm3
    end
  end
end
