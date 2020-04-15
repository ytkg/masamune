# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all

  def twitter_link
    h.link_to "@#{screen_name}", "https://twitter.com/#{screen_name}", target: '_blank', rel: 'noopener'
  end
end
