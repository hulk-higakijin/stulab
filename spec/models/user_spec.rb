require 'rails_helper'

RSpec.describe User, type: :model do
  describe '登録' do
    context '成功' do
      it '登録できる' do
        user = create(:user)
        expect(user.valid?).to eq(true)
      end
    end

    context '失敗' do
      it '名前が必要' do
        user = User.create(
          name: nil,
          email: 'kanikani.zuwai@example.com',
          password: 'kanikanizuwai',
          password_confirmation: 'kanikanizuwai'
        )
        expect(user.valid?).to eq(false)
      end

      it '名前は空文字にはできない' do
        user = User.create(
          name: " ",
          email: 'kanikani.zuwai@example.com',
          password: 'kanikanizuwai',
          password_confirmation: 'kanikanizuwai'
        )
        expect(user.valid?).to eq(false)
      end

      it '名前は15文字以内' do
        user = User.create(
          name: 'a' * 16,
          email: 'kanikani.zuwai@example.com',
          password: 'kanikanizuwai',
          password_confirmation: 'kanikanizuwai'
        )
        expect(user.valid?).to eq(false)
      end

      it 'メールアドレスが必要' do
        user = User.create(
          name: '野生のミシシッピズワイガニ',
          email: nil,
          password: 'kanikanizuwai',
          password_confirmation: 'kanikanizuwai'
        )
        expect(user.valid?).to eq(false)
      end

      it 'メールアドレスは空文字にはできない' do
        user = User.create(
          name: '野生のミシシッピズワイガニ',
          email: '',
          password: 'kanikanizuwai',
          password_confirmation: 'kanikanizuwai'
        )
        expect(user.valid?).to eq(false)
      end

      it 'パスワードを一致していないといけない' do
        user = User.create(
          name: '野生のミシシッピズワイガニ',
          email: 'kanikani.zuwai@example.com',
          password: 'kanikanizuwai',
          password_confirmation: 'zuwaikanikani'
        )
        expect(user.valid?).to eq(false)
      end

      it 'パスワードは6文字以上' do
        user = User.create(
          name: '野生のミシシッピズワイガニ',
          email: 'kanikani.zuwai@example.com',
          password: 'zuwai',
          password_confirmation: 'zuwai'
        )
        expect(user.valid?).to eq(false)
      end
    end
  end

  describe '更新' do
    before do
      @user = create(:user)
    end

    context '成功' do
      it '自己紹介が更新できる' do
        introduction = 'a' * 160
        expect(@user.update(introduction: introduction)).to eq(true)
      end

      it 'public_uidが更新できる' do
        expect(@user.update(introduction: "wildzuwaikani")).to eq(true)
      end
    end

    context '失敗' do
      it '自己紹介は160字以内' do
        introduction = 'a' * 161
        expect(@user.update(introduction: introduction)).to eq(false)
      end

      it 'public_uidは重複しない' do
        public_uid = @user.public_uid
        user_a = User.create(
          name: 'aaa',
          email: 'aaa@example.com',
          password: 'aaaaaa',
          password_confirmation: 'aaaaaa'
        )
        expect(user_a.update(public_uid: public_uid)).to eq(false)
      end

      it 'public_uidは15文字以下' do
        public_uid = 'a' * 16
        expect(@user.update(public_uid: public_uid)).to eq(false)
      end
    end

  end
end
