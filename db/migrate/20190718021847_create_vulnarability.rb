class CreateVulnarability < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'
    create_table :vulnarabilities do |t|
      t.string :application
      t.string :version
      t.jsonb :file, default: '{}'
      t.jsonb :cves, default: '{}'
      t.datetime :latest_date
      t.references :computer
    end
  end
end
