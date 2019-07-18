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

class Computer < ApplicationRecord
  extend FriendlyId
  has_many :user_activities
  has_many :users, through: :user_activities
  has_many :vulnarabilities

  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    ["#{rand(36**10).to_s(36)}-#{hostname}" ]
  end
end
