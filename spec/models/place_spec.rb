require 'rails_helper'

RSpec.describe Place, type: :model do
  before do 
    @place = FactoryBot.build(:place)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@place.valid?).to eq(true)
    end
  end

end
