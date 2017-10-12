require 'spec_helper'

describe Spree::Product do
  let(:product) { create :product }
  let(:variant) { create :base_variant, product: product }
  let(:image_green) { create :image }
  let(:image_blue) { create :image }

  before do
    Spree::VariantImage.create!(variant: variant, image: image_green)
    Spree::VariantImage.create!(variant: variant, image: image_blue)
    variant.reload
    product.reload
  end

  describe '#variant_images' do
    it 'returns unique list of variant images' do
      expect(product.variant_images.size).to eq(2)
      expect(product.variant_images).to include(image_blue, image_green)
    end
  end

end
