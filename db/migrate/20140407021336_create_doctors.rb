class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.boolean :delete_flg

      t.timestamps
    end
  end
end
