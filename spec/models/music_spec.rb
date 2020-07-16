require 'rails_helper'

RSpec.describe Music, type: :model do
  before do 
    @music = FactoryBot.build(:music)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@music.valid?).to eq(true)
    end
  end
  
end
