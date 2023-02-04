class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def stay_days
    (end_date.to_date - start_date.to_date).to_i
  end
  
  def total_price
    self.room.price * people * stay_days
  end
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :people, presence: true
  validate :start_check
  validate :end_check

  def start_check
    errors.add(:start_date, "は今日より前の日付は選択できません") if start_date != nil && start_date < Date.today
  end
  
  def end_check
    errors.add(:end_date, "はチェックイン日より後の日付を選択してください") if start_date != nil && end_date != nil && start_date > end_date
  end
end
