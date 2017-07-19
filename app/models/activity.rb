class ActivitySerializer < ActiveModel::Serializer
  attributes  :id,
              :account_id,
              :date,
              :text

  def date
    d = object.date.in_time_zone("America/Denver")
    {
      year: d.year,
      month: d.month,
      day: d.day
    }
  end
end

class Activity < ApplicationRecord
  belongs_to :account

  default_scope {order(date: :desc)}

  scope :search, -> term {
    where("text like ?", "%#{term}%")
  }
end
