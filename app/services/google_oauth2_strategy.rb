class GoogleOauth2Strategy < BaseStrategy
  def config
    [:google_oauth2, Rails.application.secrets.google_provider_key, Rails.application.secrets.google_provider_secret]
  end

  def valid_mail?(email)
     %w(the-cocktail.com tcanalysis.com).include?(email.split("@").last)
  end

  def create(auth)
    return unless valid_mail?(auth['info']['email'])
    super
  end

  def friendly_name
    "google"
  end
end
