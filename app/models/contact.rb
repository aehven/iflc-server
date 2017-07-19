class ContactSerializer < ActiveModel::Serializer
  attributes  :id,
              :first_name,
              :last_name,
              :ma,
              :account_name,
              :account_id,
              :phone,
              :cellphone,
              :email,
              :street,
              :city,
              :state,
              :zip,
              :kind,
              :sunday,
              :monday,
              :tuesday,
              :wednesday,
              :thursday,
              :friday,
              :saturday

  def account_name
    object.account&.name
  end
end

class Contact < ApplicationRecord
  include HasKind
  serialize :days_in_office

  belongs_to :account

  # http://stackoverflow.com/a/21818014
  has_many :favorites, as: :favoritable

  default_scope {order(last_name: :asc).order(first_name: :asc)}

  scope :search, -> term {
    where("first_name like ? or last_name like ? or phone like ? or email like ? or street like ? or city like ? or zip like ?",
    "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
  }

  def name
    "#{last_name}, #{first_name}"
  end
end
