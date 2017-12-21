Spree::Variant.class_eval do
  has_many :variant_images, class_name: '::Spree::VariantImage', dependent: :destroy
  has_many :variant_image_images,
           -> { includes(:variant_images).references(:variant_images).order('spree_assets_variants.position ASC')},
           through: :variant_images, source: :image

  has_many :display_variant_images, -> (object) {
    master = object.product.master
    variant_ids = [object.id, master.id].uniq
    unscope(:where).where(variant_id: variant_ids)
  }, class_name: '::Spree::VariantImage'

  has_many :display_images, through: :display_variant_images, source: :image

  alias_method :images, :variant_image_images
  alias_method :images=, :variant_image_images=

end
