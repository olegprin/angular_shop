class Angular < ActiveRecord::Base

	validates :title, presence: true, length: { minimum: 1, maximum: 250 }
  validates :body, presence: true

end
