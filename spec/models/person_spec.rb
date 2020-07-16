require 'rails_helper'

RSpec.describe Person, type: :model do
  before do 
    @person = FactoryBot.build(:person)
  end

  describe 'バリデーション' do
    it 'それぞれ値が設定されていれば、OK' do
      expect(@person.valid?).to eq(true)
    end
  end

end
