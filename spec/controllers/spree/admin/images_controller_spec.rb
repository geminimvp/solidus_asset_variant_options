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
    end
  end
end
