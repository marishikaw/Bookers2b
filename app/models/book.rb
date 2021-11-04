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
	
	
	
	scope :created_thisweek, -> { where(created_at: from...to) }
end