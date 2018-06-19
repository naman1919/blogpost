class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_secure_password
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :comments
  has_many :posts, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  
  scope :publish, -> { where(publish: true) }

  accepts_nested_attributes_for :images
  validates :first_name, :last_name, :city, presence: true
  

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
