require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do 
    @tag = FactoryBot.build(:tag)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@tag.valid?).to eq(true)
    end
  end

end
