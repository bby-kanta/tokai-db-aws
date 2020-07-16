require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do

    it 'nameとemailとpasswordに値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが暗号化されているか' do
      expect(@user.encrypted_password).to_not eq "password"
    end

  end
end