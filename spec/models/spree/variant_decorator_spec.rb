require 'spec_helper'

describe Spree::Variant do
  let(:variant) { create :base_variant }
  let(:image_green) { create :image }
  let(:image_blue) { create :image }

  before do
    variant.images << image_green
    variant.images << image_blue
  end

  describe '#images' do
    it "should have many images" do
      expect(variant.images.size).to eq(2)
    end

    it 'orders image by variant image position' do
      variant.variant_images.where(image: image_blue).first.update_attributes(position: 0)
      variant.variant_images.where(image: image_green).first.update_attributes(position: 1)

      expect(variant.images.first).to eq image_blue
      expect(variant.images.last).to eq image_green

      variant.variant_images.where(image: image_blue).first.update_attributes(position: 1)
      variant.variant_images.where(image: image_green).first.update_attributes(position: 0)

      expect(variant.images.first).to eq image_green
      expect(variant.images.last).to eq image_blue
    end

    it 'disallows duplicate associations' do
      expect { variant.images << image_green }.to raise_error ActiveRecord::RecordInvalid, /Image has already been taken/
    end
  end

  describe '#display_images' do
    subject { variant.display_images }
    context 'when the master variant has images' do
      let(:product) { variant.product }
      let(:master_variant) { product.master }
      let(:image_red) { create :image }

      before do
        master_variant.images << image_red
        expect(master_variant.images.size).to eq(1)
      end

      it 'includes master variant images' do
        expect(subject.size).to eq(3)
      end
    end

  end
end
