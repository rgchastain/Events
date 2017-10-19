class Event < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  has_many :attends
  has_many :attendees, through: :attends, source: :user

  validates :name, :city, presence: true
  validates :date, timeliness: { on_or_after: lambda { Date.current }, type: :date }
  			

  def future_date
  	if date.present? && date < Date.now
  		errors.add(:date, "can't be in the past.")
  	end
  end
end
