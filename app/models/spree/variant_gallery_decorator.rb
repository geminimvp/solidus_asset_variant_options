module Spree
  module VariantGalleryDecorator
    def images
      @images ||= @variant.display_images
    end

    Spree::VariantGallery.prepend(self)
  end
end
