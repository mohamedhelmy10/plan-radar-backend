class Status < ApplicationRecord
  # Associations
  has_many :tickets

  # Validations
	validates :name, presence: true, uniqueness: true

	# Enum for status name
	enum name: { pending: 0, in_progress: 1, completed: 2, on_hold: 3, resolved: 4, over_due: 5 }
end
