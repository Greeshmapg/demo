class Team < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tasks
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
  validates :max_no_users, presence: true,
            :numericality => true
  validates :image, presence: true
  validate :image_size_validation

private

  def image_size_validation
    if image.size > 1.megabytes
        errors.add(:base, "Image should be less than 1MB")
    end
  end

end
