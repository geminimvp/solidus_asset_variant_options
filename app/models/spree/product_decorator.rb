Spree::Product.class_eval do
  has_many :nonuniq_variant_images, source: :variant_image_images, through: :variants_including_master

  def variant_images
    nonuniq_variant_images.reorder(:position).distinct
  end

  def display_image
    gallery.images.first || Spree::Image.new
  end
end
