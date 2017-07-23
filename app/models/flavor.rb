class ContactSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :color,
              :cee_name

  def cee_name
    object.cee&.name
  end
end

class Flavor < ApplicationRecord
  belongs_to :cee

  # http://stackoverflow.com/a/21818014
  has_many :favorites, as: :favoritable

  default_scope {order(name: :asc)}

  scope :search, -> term {
    where("name like ? or color like",
    "%#{term}%", "%#{term}%")
  }
end
