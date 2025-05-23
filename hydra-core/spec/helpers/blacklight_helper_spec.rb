require 'spec_helper'

describe BlacklightHelper do
  describe "document_partial_name" do
    let(:field_name) { 'has_model_s' }

    let(:config) do
      Blacklight::Configuration.new.configure do |config|
        config.show.display_type_field = field_name
      end
    end

    before do
      allow(helper).to receive(:blacklight_config).and_return(config)
      allow(helper).to receive(:blacklight_configuration_context).and_return(helper)
      allow(helper).to receive(:evaluate_if_unless_configuration).and_return(true)
    end

    it "changes camel case to underscored lowercase" do
      expect(helper.send(:document_partial_name, 'has_model_s' => ["Presentation"])).to eq "presentation"
      expect(helper.send(:document_partial_name, 'has_model_s' => ["GenericContent"])).to eq("generic_content")
    end

    context "with a single valued field" do
      let(:field_name) { 'has_model_s' }
      it "should support single valued fields" do
        expect(helper.send(:document_partial_name, 'has_model_s' => "Chicken")).to eq "chicken"
      end
    end

    it "handles periods" do
      expect(helper.send(:document_partial_name, 'has_model_s' => ["text.PDF"])).to eq "text_pdf"
    end
  end
end
