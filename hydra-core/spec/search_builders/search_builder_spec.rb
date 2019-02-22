require 'spec_helper'

RSpec.describe Hydra::SearchBuilder do
  let(:context) { CatalogController.new }
  let(:user) { double('user', user_key: 'joe') }
  let(:current_ability) { double('ability', user_groups: [], current_user: user) }
  let(:search_builder) { described_class }

  subject do
    search_builder.new(context, ability: current_ability)
  end

  it "extends classes with the necessary Hydra modules" do
    expect(described_class.included_modules).to include(Hydra::AccessControlsEnforcement)
  end

  context "when a query is generated" do
    it "triggers add_access_controls_to_solr_params" do
      expect(subject).to receive(:apply_gated_discovery)
      subject.query
    end
  end
end
