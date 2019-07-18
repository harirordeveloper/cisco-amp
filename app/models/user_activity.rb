# == Schema Information
#
# Table name: user_activities
#
#  id            :bigint           not null, primary key
#  detected_date :datetime
#  detection     :string
#  event_type    :string
#  file          :jsonb
#  severity      :string
#  user_name     :string
#  computer_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_user_activities_on_computer_id  (computer_id)
#  index_user_activities_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (computer_id => computers.id)
#  fk_rails_...  (user_id => users.id)
#

class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :computer

  # This will allow us to strore the JSON data to postgres
  serialize :file, Hash
end
