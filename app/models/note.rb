class ActivitySerializer < ActiveModel::Serializer
  attributes  :id,
              :cee_id,
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

class Note < ApplicationRecord
  belongs_to :cee

  default_scope {order(date: :desc)}

  scope :search, -> term {
    where("text like ?", "%#{term}%")
  }
end
