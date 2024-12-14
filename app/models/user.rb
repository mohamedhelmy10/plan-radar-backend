class User < ApplicationRecord
    # Associations
	has_many :notifications
	has_many :tickets, foreign_key: :assigned_user_id

	# Validations
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
end
