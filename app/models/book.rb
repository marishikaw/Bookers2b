class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
	scope :created_yesterday, -> { where(created_at: Time.zone.yesterday.all_day) }
	
	thisWeek_from = 6.day.ago.beginning_of_day
	thisWeek_to = Time.zone.now.end_of_day
	scope :created_thisweek, -> { where(created_at: thisWeek_from...thisWeek_to) }
	
	lastWeek_from = 13.day.ago.beginning_of_day
	lastWeek_to = 7.day.ago.end_of_day
	scope :created_lastweek, -> { where(created_at: lastWeek_from...lastWeek_to) }
	
	# scope :created_two_days_ago, -> { where(created_at: (today - 2.day).all_day) }
	# scope :created_three_days_ago, -> { where(created_at: (today - 3.day).all_day) }
	# scope :created_four_days_ago, -> { where(created_at: (today - 4.day).all_day) }
	# scope :created_five_days_ago, -> { where(created_at: (today - 5.day).all_day) }
	# scope :created_six_days_ago, -> { where(created_at: (today - 6.day).all_day) }
end