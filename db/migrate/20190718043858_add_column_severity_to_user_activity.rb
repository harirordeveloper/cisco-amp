class AddColumnSeverityToUserActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :user_activities, :severity, :string
    add_column :user_activities, :event_type, :string
    add_column :user_activities, :detection, :string
    add_column :user_activities, :detected_date, :datetime
    add_column :user_activities, :user_name, :string
    add_column :user_activities, :file, :jsonb, default: '{}'
  end
end
