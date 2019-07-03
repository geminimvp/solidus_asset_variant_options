Spree::Admin::ImagesController.class_eval do
  new_action.before :set_default_variants
  create.before     :set_variants
  update.before     :set_variants

  private

    def set_default_variants
      @image.variant_ids = [@product.master.id]
    end

    def set_variants
      @image.validate_variant_presence = false
      @image.variant_ids = viewable_ids
    end

    def viewable_ids
      # If viewable_ids is blank fall back to viewable_id
      #
      # This allows the existing drag / drop image upload form to continue to
      # function with no additional modifications
      #
      viewable_ids = if params[:image][:viewable_ids].present?
                       params[:image][:viewable_ids]
                     elsif params[:image][:viewable_id].present?
                       [params[:image][:viewable_id]]
                     end

      # Drop nil / empty string values
      viewable_ids = Array(viewable_ids).reject(&:blank?)

      # fallback to the master variant
      unless viewable_ids.present?
        viewable_ids = [@product.master.id]
      end

      # return value to ensure assignment inside set_variants
      viewable_ids
    end
end
