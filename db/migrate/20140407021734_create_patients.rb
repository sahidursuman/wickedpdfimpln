class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender, :limit=>1
      t.references :doctor, index: true
      t.boolean :delete_flg

      t.timestamps
    end
  end
end
