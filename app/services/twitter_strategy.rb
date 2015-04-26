class TwitterStrategy < BaseStrategy
  def config
    [:twitter, Rails.application.secrets.twitter_provider_key, Rails.application.secrets.twitter_provider_secret]
  end

  def friendly_name
    "twitter"
  end
end
