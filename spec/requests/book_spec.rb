require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:user) { create(:user) }
  let(:author) { create(:author) }
  let(:valid_params) do
    {
      title: 'this is available book',
      introduction: 'this is available book. create super future.',
      price: 1000
    }
  end
  let(:invalid_params) do
    {
      title: nil,
      introduction: 'a',
      price: 0
    }
  end

  describe "GET /index" do
    it '正常なレスポンス' do
      get books_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    before do
      @book = create(:book)
    end
    it '正常なレスポンス' do
      get book_path(@book)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /new' do
    context '未ログイン時' do
      it 'アクセスできない' do
        expect do
          get new_book_path
        end.to raise_error(NoMethodError)
      end
    end

    context '一般ユーザー時' do
      it 'アクセスできない' do
        expect do
          sign_in user
          get new_book_path
        end.to raise_error(NoMethodError)
      end
    end

    context '著者時' do
      it '正常なレスポンス' do
        sign_in author
        get new_book_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /edit' do
    before do
      @book = create(:book)
    end

    context '未ログイン時' do
      it 'アクセスできない' do
        expect do
          get edit_book_path(@book)
        end.to raise_error(NoMethodError)
      end
    end

    context '著者本人でない場合' do
      it 'アクセスできない' do
        expect do          
          new_user = User.create(
            name: 'new_user',
            email: 'new.user@example.com',
            password: 'IamNewUser',
            password_confirmation: 'IamNewUser'
          )
          new_book = new_user.books.create(valid_params)
          sign_in author
          get edit_book_path(new_book)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context '著者本人の場合' do
      it '正常なレスポンス' do
        new_user = User.create(
          name: 'new_user',
          email: 'new.user@example.com',
          password: 'IamNewUser',
          password_confirmation: 'IamNewUser',
          author: true
        )
        new_book = new_user.books.create(valid_params)
        sign_in new_user
        get edit_book_path(new_book)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /books' do
    context '未ログイン時' do
      it 'エラーが起きる' do
        expect do
          post books_path, params: { book: valid_params }
        end.to raise_error(NoMethodError)
      end
    end

    context '一般ユーザー時' do
      before do
        sign_in user
      end

      it 'エラーが起きる' do
        expect do
          post books_path, params: { book: valid_params }
        end.to raise_error(NoMethodError)
      end
    end

    context '著者時' do
      before do
        sign_in author
      end

      context '成功' do
        it 'レコードが一つ増える' do
          expect do
            post books_path, params: { book: valid_params }
          end.to change { Book.count }.by(1)
        end

        it 'タイトルが保存される' do
          post books_path, params: { book: valid_params }
          expect(Book.last.title).to eq('this is available book')
        end

        it 'showページにリダイレクト' do
          post books_path, params: { book: valid_params }
          expect(response).to redirect_to book_path(Book.last.id)
        end
      end

      context '失敗' do
        it '無効なパラメータは保存できない' do
          expect do
            post books_path, params: { book: invalid_params }
          end.to change { Book.count }.by(0)
        end

        it 'リダイレクトしない' do
          post books_path, params: { book: invalid_params }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PUT /books/:id' do
    before do
      sign_in author
      post books_path, params: { book: valid_params }
      sign_out author
    end

    context '未ログイン時' do
      it 'エラーが起きる' do
        expect do
          put book_path(Book.last), params: { book: valid_params }
        end.to raise_error(NoMethodError)
      end
    end

    context '著者本人でない場合' do
      before do
        new_user = User.create(
          name: 'new_user',
          email: 'new.user@example.com',
          password: 'IamNewUser',
          password_confirmation: 'IamNewUser',
          author: true
        )
        sign_in new_user
      end

      it 'エラーが起きる' do
        expect do
          put book_path(Book.last), params: { book: valid_params }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context '著者本人の場合' do
      before do
        sign_in author
      end

      context '成功' do
        it 'レコード数は変化しない' do
          expect do
            put book_path(Book.last), params: {
              book: {
                title: 'this is my updated book.'
              }
            }
          end.to change{ Book.count }.by(0)
        end

        it 'タイトルは更新される' do
          put book_path(Book.last), params: {
            book: {
              title: 'this is my updated book.'
            }
          }
          expect(Book.last.title).to eq('this is my updated book.')
        end

        it 'showページにリダイレクトする' do
          put book_path(Book.last), params: {
            book: {
              title: 'this is my updated book.'
            }
          }
          expect(response).to redirect_to book_path(Book.last)
        end
      end

      context '失敗' do
        it 'タイトルは更新されない' do
          put book_path(Book.last), params: { book: invalid_params }
          expect(Book.last.title).to eq('this is available book')
        end

        it 'リダイレクトしない' do
          put book_path(Book.last), params: { book: invalid_params }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
