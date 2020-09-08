class Detail < ApplicationRecord
  attribute :value, :text, default: '{}'
  belongs_to :admin_user

  def last_login_date
    value_hash[:last_login_date]
  end

  def update_last_login_date(last_login_date)
    update_value(:last_login_date, last_login_date)
  end

  private

  def value_hash
    JSON.parse(value, symbolize_names: true)
  end

  def update_value(key, val)
    update!(value: value_hash.merge(key => val).to_json)
  end
end
