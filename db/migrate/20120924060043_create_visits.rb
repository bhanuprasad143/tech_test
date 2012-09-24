class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.belongs_to :user
      t.string :country

      t.timestamps
    end
    add_index :visits, :user_id
  end
end
