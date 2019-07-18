# == Schema Information
#
# Table name: auth_records
#
#  id         :bigint           not null, primary key
#  api_client :string
#  api_key    :string
#  user_id    :bigint
#
# Indexes
#
#  index_auth_records_on_user_id  (user_id)
#

class AuthRecord < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
