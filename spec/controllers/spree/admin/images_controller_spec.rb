require 'spec_helper'

module Spree
  module Admin
    RSpec.describe ImagesController, type: :request do
      stub_authorization!

      describe 'GET #new' do
        # create a product with >1 variant to de-sync product IDs
        # from variant IDs
        let!(:preexisting_variant) { create(:variant) }
        let!(:product) { create(:product) }
        let(:master) { product.master }

        it 'defaults images to the master variant' do
          expect(product.id).to_not eq(master.id)
          get "/admin/products/#{product.id}/images/new"
          expect(assigns(:image).variant_ids).to include(master.id)
        end
      end

      describe 'POST #create' do
        let(:variant) { create(:variant) }
        let(:product) { variant.product }

        let(:create_path) {
          "/admin/products/#{product.id}/images"
        }
        let(:create_params) {
          {
            image: {
              viewable_ids: [variant.id],
            },
          }
        }

        around(:each) do |example|
          prev_value = ActionController::Base.allow_forgery_protection
          ActionController::Base.allow_forgery_protection = false
          example.run
          ActionController::Base.allow_forgery_protection = prev_value
        end

        it 'sets the viewable IDs to the passed parameters' do
          post create_path, params: create_params
          expect(assigns(:image).viewable_ids).to eq([variant.id.to_s])

        end

      end
    end
  end
end
