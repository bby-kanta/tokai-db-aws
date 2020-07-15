require 'rails_helper'

RSpec.describe Penalty, type: :model do
  before do 
    @penalty = FactoryBot.build(:penalty)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@penalty.valid?).to eq(true)
    end
  end

end