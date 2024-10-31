class RenameUserIdToBorrowerId < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :user_id, :borrower_id
  end
end
