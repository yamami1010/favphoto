class Post < ApplicationRecord
  
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :image, presence: true
  validate :image_size
  
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  
  def like_count
    Like.where(post: self).count
  end
  
  private
  
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less then 5MB")
    end
  end
  
  
end
