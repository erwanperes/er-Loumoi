# db/migrate/YYYYMMDDHHMMSS_fix_reservation_columns.rb
class FixReservationColumns < ActiveRecord::Migration[7.0]
  def change
    # Si la colonne user_id existe et que borrower_id n'existe pas
    if column_exists?(:reservations, :user_id) && !column_exists?(:reservations, :borrower_id)
      rename_column :reservations, :user_id, :borrower_id
    end

    # Si borrower_id n'existe pas du tout
    unless column_exists?(:reservations, :borrower_id)
      add_column :reservations, :borrower_id, :bigint
    end

    # Ajout des index si nécessaire
    add_index :reservations, :borrower_id unless index_exists?(:reservations, :borrower_id)
    add_index :reservations, :item_id unless index_exists?(:reservations, :item_id)
  end
end