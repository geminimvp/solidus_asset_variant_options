module Spree
  module Gallery
    module VariantGalleryDecorator
      def images
        @images ||= @variant.display_images
      end

      Spree::Gallery::VariantGallery.prepend(self)
    end
  end
end
