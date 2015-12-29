class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :code, unique: true, allow_nil: false
      t.string :title

      t.timestamps null: false
    end
  end
end
