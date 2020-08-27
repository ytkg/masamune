class AdminUser < ApplicationRecord
  has_many :friends
  has_many :followers

  def self.create_or_update_from_auth(auth)
    find_or_initialize_by(id: auth[:uid]).tap do |user|
      user.update!(
        screen_name: auth[:info][:nickname],
        name: auth[:info][:name],
        image_url: auth[:info][:image],
        token: auth[:credentials][:token],
        secret: auth[:credentials][:secret]
      )
    end
  end
end
