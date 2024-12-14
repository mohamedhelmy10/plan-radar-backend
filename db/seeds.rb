# db/seeds.rb

statuses = [
  { name: :pending },
  { name: :in_progress },
  { name: :completed },
  { name: :on_hold },
  { name: :resolved },
  { name: :over_due }
]

statuses.each do |status|
  Status.find_or_create_by!(status)
end

puts "Seeded #{statuses.size} statuses."
