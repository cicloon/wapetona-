class BaseStrategy
  def initialize(user_class)
    @user_class = user_class
  end

  def create(auth)
    @user_class.create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def find(auth)
    @user_class.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first
  end

  def find_or_create(auth)
    find(auth) || create(auth)
  end

  def provider_for(provider)
    provider = "#{provider}_strategy".classify.safe_constantize.try(:new, @user_class)
    provider if provider.try(:enabled?)
  end

  def find_or_create_from_auth_hash(auth)
    provider_for(auth['provider']).try(:find_or_create, auth)
  end

  def enabled?
    true
  end

  def self.configure
    Rails.application.config.middleware.use OmniAuth::Builder do
      BaseStrategy.providers.each do |(_, provider_obj)|
        provider *provider_obj.config
      end
    end
  end

  def self.providers
    @@providers_names ||= OmniAuth::Strategies
      .constants
      .map { |provider| p = provider_for(provider); [provider, provider_for(provider)] if p}
      .compact
      .to_h
  end

  def self.provider? provider
    BaseStrategy.providers.keys.include?(provider.to_s.classify.to_sym)
  end

  def self.provider_for provider
    new(nil).provider_for(provider)
  end
end
