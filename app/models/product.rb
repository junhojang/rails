class Product < ActiveRecord::Base
  validates :title,  :desc,  :img_url,  presence: true
  validates_numericality_of :price, :greater_than_or_equal_to => 1
  validates :title,  uniqueness: true
  validates :img_url,  allow_blank: true,  format: {
  	with: %r{\.(gif|jpg|png)\Z}i,
  	message: 'must be a URL for GIF, JPG, PNG image'
  }
end
