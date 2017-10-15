class DishUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [600, 400]

  version :middle do
    process resize_to_fill: [280, 280]
  end

  version :thumb do
    process resize_to_fill: [60,60]
  end

  # Choose what kind of storage to use for this uploader:
  storage :aws

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end


end
