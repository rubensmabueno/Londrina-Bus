class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :line, index: true, foreign_key: true, allow_nil: false, on_delete: :cascade
      t.references :origin, index: true, foreign_key: true, allow_nil: false, on_delete: :cascade
      t.references :destination, index: true, foreign_key: true, allow_nil: false, on_delete: :cascade
      t.references :schedule, index: true, foreign_key: true, allow_nil: false, on_delete: :cascade
      t.integer :day

      t.timestamps null: false
    end
  end
end
