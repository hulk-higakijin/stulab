json.extract! book, :id, :title, :introduction, :price, :likes_count, :created_at, :updated_at
json.url book_url(book, format: :json)
