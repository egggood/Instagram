if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region: 'ap-northeast-1',
    }

    config.fog_directory = 'kai-instagram-123'
    config.asset_host = 'https://s3.amazonaws.com/kai-instagram-123'
  end
end