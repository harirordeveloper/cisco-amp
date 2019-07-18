# == Schema Information
#
# Table name: vulnarabilities
#
#  id          :bigint           not null, primary key
#  application :string
#  cves        :jsonb
#  file        :jsonb
#  latest_date :datetime
#  version     :string
#  computer_id :bigint
#
# Indexes
#
#  index_vulnarabilities_on_computer_id  (computer_id)
#

class Vulnarability < ApplicationRecord
  belongs_to :computer, dependent: :destroy

  # This will allow us to strore the JSON data to postgres
  serialize :file, Hash
  serialize :aves, Array
end
