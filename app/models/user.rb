class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    send("create_with_#{auth['provider']}", auth) if ["google_oauth2", "twitter"].include?(auth['provider'].to_s)
  end

  def self.create_with_google_oauth2(auth)
    if ["the-cocktail.com", "tcanalysis.com"].include?(auth['info']['email'].split("@").last)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
           user.name = auth['info']['name'] || ""
        end
      end
    end
  end

  def self.create_with_twitter(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end
