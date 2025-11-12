require 'spec_helper'

describe DownloadsController do
  before do
    Rails.application.routes.draw do
      resources :downloads
      devise_for :users
      root to: 'catalog#index'
    end
  end

  describe "routing" do
    it "routes" do
      assert_recognizes({ controller: "downloads", action: "show", id: "test1" },
                        "/downloads/test1?filename=my%20dog.jpg")
    end
  end

  describe "with a file" do
    before do
      class ContentHolder < ActiveFedora::Base
        include Hydra::AccessControls::Permissions
        has_subresource 'thumbnail'
      end
      @user = User.new.tap {|u| u.email = 'email@example.com'; u.password = 'password'; u.save}
    end
    let(:obj) do
      ContentHolder.new.tap do |obj|
        obj.add_file('fizz', path: 'buzz', original_name: 'buzz.png', mime_type: 'image/png')
        obj.add_file('foobarfoobarfoobar', path: 'content', original_name: 'world.png', mime_type: 'image/png')
        obj.add_file("It's a stream", path: 'descMetadata', original_name: 'metadata.xml', mime_type: 'text/plain')
        obj.read_users = [@user.user_key]
        obj.save!
      end
    end

    after do
      obj.destroy
      Object.send(:remove_const, :ContentHolder)
    end

    describe "overriding the default asset param key" do
      before do
        Rails.application.routes.draw do
          scope 'objects/:object_id' do
            get 'download' => 'downloads#show'
          end
        end
        sign_in @user
      end
      it "uses the custom param value to retrieve the asset" do
        allow(controller).to receive(:asset_param_key).and_return(:object_id)
        get :show, params: { object_id: obj }
        expect(response).to be_successful
      end
    end
  end
end
