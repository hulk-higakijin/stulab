require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '登録' do
    before do
      @user = create(:user)
    end

    let(:book) {
      @user.books.new(
        title: 'ズワイガニ観察日記を作ってみよう！',
        introduction: '太平洋に生息する野生のミシシッピズワイガニの生態について調査していきます。',
        price: 1000
      )
    }

    context '成功' do
      it '登録できる' do
        expect(book.save).to eq(true)
      end
    end

    context '失敗' do
      it '投稿ユーザーが必要' do
        no_user_book = Book.new(
          title: 'ズワイガニ観察日記',
          introduction: '太平洋に生息する野生のミシシッピズワイガニの生態について調査していきます。',
          price: 1000
        )
        expect(no_user_book.save).to eq(false)
      end

      it 'タイトルは必須' do
        book.title = nil
        expect(book.save).to eq(false)
      end

      it 'タイトルは10文字以上40文字以下' do
        book.title = 'a' * 9
        expect(book.save).to eq(false)
        book.title = 'b' * 41
        expect(book.save).to eq(false)
        book.title = 'c' * 40
        expect(book.save).to eq(true)
      end

      it '紹介文は必須' do
        book.introduction = nil
        expect(book.save).to eq(false)
      end

      it '紹介文は20文字以上200字以下' do
        book.introduction = 'a' * 19
        expect(book.save).to eq(false)
        book.introduction = 'b' * 201
        expect(book.save).to eq(false)
        book.introduction = 'c' * 200
        expect(book.save).to eq(true)
      end

      it '価格は1000円以上5000円以下' do
        book.price = 999
        expect(book.save).to eq(false)
        book.price = 5001
        expect(book.save).to eq(false)
        book.price = 5000
        expect(book.save).to eq(true)
      end
    end
  end

end
