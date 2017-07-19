class FavoriteSerializer < ActiveModel::Serializer
  attributes  :id,
              :favoritable_type,
              :favoritable_id,
              :user_id
end

class Favorite < ApplicationRecord
  # http://stackoverflow.com/a/21818014
  belongs_to :favoritable, polymorphic: true
  belongs_to :user, inverse_of: :favorites

  validates :user_id, uniqueness: {
    scope: [:favoritable_id, :favoritable_type],
    message: 'can only favorite an item once'
  }
end
