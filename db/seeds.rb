user = User.create!(
  name: '野生のミシシッピズワイガニ',
  email: 'kanikani.zuwai@example.com',
  password: '123456',
  password_confirmation: '123456',
  public_uid: 'kanikanizuwai',
  author: true
)
## 管理者権限をつける
user.update_attribute(:admin, true)

user.books.create!(
  title: '戊辰戦争の舞台を歩いてみよう！',
  introduction: '明治新政府と旧幕府軍の戦いである戊辰戦争。舞台は大坂の「鳥羽伏見の戦い」から「江戸城無血開城」、そして蝦夷の「五稜郭の戦い」まで。全国を巻き込んだまさに「日本最大の内戦」。その舞台をインターネットを使って歩いてみましょう。',
  price: 1500,
  likes_count: 0
)

book = user.books.create!(
  title: '坂本龍馬が誰に暗殺されたか考察してみよう！',
  introduction: '幕末の偉人として取り上げられる坂本龍馬ですが、彼は誕生日に何者かによって暗殺されました。その犯人はいまだにわかっていません。 彼を暗殺を実行したのは一体誰なのか。その正体を当時の社会情勢を踏まえて考察していきましょう。',
  price: 1000,
  likes_count: 0
)

['新撰組説', '水戸藩説', '薩摩藩説', '土佐藩説'].each do |e|
  chapter = book.chapters.create!(caption: e, number: book.chapters.length + 1 )
  ActionText::RichText.create!(record_type: 'Chapter', record_id: chapter.id, name: 'content', body: Faker::Lorem.paragraph(sentence_count: 100) )
end


5.times.each do |n|
  name = Faker::Name.name
  fake_user = User.create!(
    name: name,
    email: "#{n.to_s + Faker::Internet.email(name: name, domain: 'example')}",
    password: '123456',
    password_confirmation: '123456',
    public_uid: "#{name + n.to_s}",
    introduction: Faker::Lorem.paragraph,
    author: true
  ) 
  book = fake_user.books.create!(
    title: Faker::Lorem.paragraph,
    introduction: Faker::Lorem.paragraph,
    price: Random.rand(1000..5000)
  )
  int = Random.rand(3..10)
  int.times.each do |n|
    chapter = book.chapters.create!(caption: Faker::Lorem.sentence, number: book.chapters.length + 1)
    ActionText::RichText.create!(record_type: 'Chapter', record_id: chapter.id, name: 'content', body: Faker::Lorem.paragraph(sentence_count: 100))
  end
end