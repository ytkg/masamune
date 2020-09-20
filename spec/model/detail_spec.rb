# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Detail, type: :model do
  describe '#last_login_date' do
    let(:admin_user) { create(:admin_user, :with_detail) }

    before do
      admin_user.detail.update(value: { last_login_date: Time.zone.today.to_s(:db) }.to_json)
    end

    it { expect(admin_user.detail.last_login_date).to eq Time.zone.today.to_s(:db) }
  end

  describe '#update_last_login_date' do
    let(:admin_user) { create(:admin_user, :with_detail) }

    before do
      admin_user.detail.update_last_login_date(Time.zone.today.to_s(:db))
    end

    it { expect(JSON.parse(admin_user.detail.value)['last_login_date']).to eq Time.zone.today.to_s(:db) }
  end
end
