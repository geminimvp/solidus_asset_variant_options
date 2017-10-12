Spree::Product.class_eval do
  def variant_images
    Spree::Image
      .joins(:variant_images).references(:variant_images)
      .where(spree_assets_variants: { variant_id: variant_ids})
  end
end
