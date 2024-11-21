class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :catch_copy, presence: true
  validates :image, presence: true
  validates :concept, presence: true
  validates :title, presence: true
  has_many :comments, dependent: :destroy

end
