module BooksHelper
  def star_rate(rate)
    array = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
    num = array.min_by { |x| (x - rate).abs }
    content_tag :span, '', class: 'star5_rating', rate: num.to_s
  end
end
