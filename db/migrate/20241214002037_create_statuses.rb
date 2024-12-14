class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.integer :name, default: 0

      t.timestamps
    end
  end
end
