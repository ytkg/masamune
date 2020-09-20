# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PointService do
  describe '#valid?' do
    let(:admin_user) { create(:admin_user) }

    before do
      admin_user.points.create(name: anything, value: 1)
    end

    subject { described_class.new(admin_user, point).valid? }

    context 'ポイントの残高が足りているとき' do
      let(:point) { { name: anything, value: -1 } }
      it { is_expected.to be_truthy }
    end

    context 'ポイントの残高が不足しているとき' do
      let(:point) { { name: anything, value: -2 } }
      it { is_expected.to be_falsey }
    end
  end

  describe '#pay' do
    let(:admin_user) { create(:admin_user) }

    before do
      admin_user.points.create(name: anything, value: 1)
    end

    context 'ポイントの残高が足りているとき' do
      let(:point) { { name: anything, value: -1 } }
      it {
        expect(described_class.new(admin_user, point).pay).to be_truthy
        expect(admin_user.points.sum(:value)).to eq 0
      }
    end

    context 'ポイントの残高が不足しているとき' do
      let(:point) { { name: anything, value: -2 } }
      it {
        expect(described_class.new(admin_user, point).pay).to be_falsey
        expect(admin_user.points.sum(:value)).to eq 1
      }
    end
  end
end
