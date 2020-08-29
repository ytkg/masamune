# frozen_string_literal: true

class TwitterUserDecorator < ApplicationDecorator
  delegate_all

  def twitter_link
    h.link_to "@#{screen_name}", "https://twitter.com/#{screen_name}", target: '_blank', rel: 'noopener'
  end

  def ff_ratio
    (friends_count.to_f / followers_count).round(2)
  end
end
