require 'rails_helper'

RSpec.describe Video, type: :model do
  before do 
    @video = FactoryBot.build(:video)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@video.valid?).to eq(true)
    end
  end


end
