class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.text :message
      t.datetime :sent_at
      t.integer :notification_type, default: 0

      t.timestamps
    end
  end
end
