class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :category_name, null: true, default: ""
      t.timestamps
      t.index [ :category_name ], unique: true
    end
  end
end
