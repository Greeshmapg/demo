class Team < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tasks
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
  validates :max_no_users, presence: true,
            :numericality => true
  validate :image_size_validation
  validate :team_size_validation


private

  def image_size_validation
    if image.size > 1.megabytes
        errors.add(:base, "Image should be less than 1MB")
    end
  end

  def team_size_validation
    if max_no_users == 0
      errors.add(:base,"Team size should be greater than zero")
    end
  end

end
