class Team < ApplicationRecord
  has_and_belongs_to_many :users
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
  validates :max_no_users, presence: true,
            :numericality => true
  validates :image, presence: true

end
