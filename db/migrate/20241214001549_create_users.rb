class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :send_due_date_reminder, default: false
      t.integer :due_date_reminder_interval, default: 0
      t.time :due_date_reminder_time, default: '08:00:00'
      t.string :time_zone, default: 'Europe/Vienna'

      t.timestamps
    end
  end
end
