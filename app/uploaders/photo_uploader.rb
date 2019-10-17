class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true

  process resize_to_limit: [1800, 1800]

  version :thumb do
    resize_to_fit 256, 256
  end

  version :preview do
    resize_to_fit 192, 256
  end

  def public_id
    if model.class == Spot
      "city_guides/cities/#{model.city.name.downcase}/spots/" + model.name.parameterize.underscore
    elsif model.class == City
      "city_guides/cities/#{model.name.downcase}/cover/" + model.name.parameterize.underscore
    end
  end

  def tags
    if model.class == Spot
      [model.city.country, model.city.name, model.category.name]
    elsif model.class == City
      ["cover"]
    end
  end
end
