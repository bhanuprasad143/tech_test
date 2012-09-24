class CreateCollects < ActiveRecord::Migration
  def change
    create_table :collects do |t|
      t.belongs_to :user
      t.string :currency

      t.timestamps
    end
    add_index :collects, :user_id
  end
end
