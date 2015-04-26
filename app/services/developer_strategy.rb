class DeveloperStrategy < BaseStrategy
  def config
    [:developer]
  end

  def enabled?
    !Rails.env.production?
  end

  def friendly_name
    "developer"
  end
end
