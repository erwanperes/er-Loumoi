class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
