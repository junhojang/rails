require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def create_test_product(_img_url)
    return Product.new(title:'title',desc:'desc',img_url:_img_url,price:100)
  end

  test "product attrs must not be empty" do
  	product=Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:desc].any?
    assert product.errors[:price].any?
    assert product.errors[:img_url].any?
  end

  test "product price must be positive" do
    product=Product.new(title:'title',desc:'desc',img_url:'ruby.jpg')
    product.price=1
    assert product.valid?

    product.price=0
    assert product.invalid?

    product.price=-1
    assert product.invalid?
  end

  test "product image must be jpg || png || gif" do
    good_case=%w{test.jpg test.JPG test.png test.PNG test.gif test.GIF}
    bad_case=%w{test.aaa test.doc test.hwp}

    good_case.each do |c|
      assert create_test_product(c).valid?
  	end

  	bad_case.each do |c|
      assert create_test_product(c).invalid?
  	end
  end

  test "product title must be unique" do
    product=Product.new(title:products(:one).title,desc:'desc',price:100,img_url:'ruby.jpg')
    assert product.invalid?
  end
end
