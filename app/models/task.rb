class Task < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :name, presence: true
  validates :duration, presence: true,
            :numericality => true

  def check_status?
    if status
      true
    else
      false
    end
  end

end
