# == Schema Information
#
# Table name: computers
#
#  id                :bigint           not null, primary key
#  active            :boolean
#  connecter_guid    :string
#  connector_version :string
#  external_ip       :string
#  group_guid        :string
#  hostname          :string
#  install_date      :datetime
#  internal_ips      :string           default([]), is an Array
#  last_seen         :datetime
#  operating_system  :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_computers_on_slug  (slug) UNIQUE
#

require 'rails_helper'

RSpec.describe Computer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
