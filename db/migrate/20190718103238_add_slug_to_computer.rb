class AddSlugToComputer < ActiveRecord::Migration[6.0]
  def change
    add_column :computers, :slug, :string
    add_index :computers, :slug, unique: true
  end
end
