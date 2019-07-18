class UserActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :computer, null: false, foreign_key: true
    end
  end
end
