class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  process resize_to_limit: [400, 400]
  
  storage :file

  def store_dir
    Settings.upload.dir
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    return if original_filename

    @name ||= Digest::MD5.hexdigest File.dirname(current_path) "#{@name}.#{file.extension}"
  end

  def default_url
    ActionController::Base.helpers.asset_path Settings.upload.default
  end
end
