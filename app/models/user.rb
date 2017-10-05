class User < ApplicationRecord
  belongs_to :role
  has_and_belongs_to_many :teams
  has_many :tasks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_NUMBER_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
  validates :phone_number,:presence => true,
                 :numericality => true,
                 format: { with: VALID_PHONE_NUMBER_REGEX },
                 :length => { :minimum => 10, :maximum => 15 }
  validates :dob, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  #validates :picture, file_size: { less_than: 2.gigabytes }
    validate :picture_size_validation



  mount_uploader :picture, PictureUploader

  def admin?
    if self.role_id == 1
      return true
    else
      return false
    end
  end

  def full_name
    [first_name,last_name].join(" ")
  end


private

  def picture_size_validation
    if picture.size > 1.megabytes
        errors.add(:base, "Image should be less than 1MB")
    end
  end

end
