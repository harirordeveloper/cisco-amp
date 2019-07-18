class CreateAuthRecord < ActiveRecord::Migration[6.0]
  def change
    create_table :auth_records do |t|
      t.string :api_client
      t.string :api_key
      t.references :user
    end
  end
end
