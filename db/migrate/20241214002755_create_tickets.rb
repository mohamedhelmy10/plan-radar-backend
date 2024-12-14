class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :assigned_user_id
      t.date :due_date
      t.references :status, foreign_key: true
      t.integer :progress, default: 0

      t.timestamps
    end
    add_foreign_key :tickets, :users, column: :assigned_user_id
  end
end
