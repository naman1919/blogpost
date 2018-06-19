class Post < ApplicationRecord

  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
 
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :body,  presence: true
  validates_presence_of :images
end
