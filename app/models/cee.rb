require 'csv'

class CeeSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :form,
             :source
end

class Cee < ApplicationRecord

  enum form: {
    gas: 100,
    liquid: 200,
    mush: 300,
    solid: 400
  }, _prefix: true

  enum source: {
    animal: 100,
    vegetable: 200,
    mineral: 300
  }, _prefix: true

  has_many :flavors, dependent: :destroy
  has_many :notes, dependent: :destroy

  # http://stackoverflow.com/a/21818014
  has_many :favorites, as: :favoritable

  default_scope {order(name: :asc)}

  scope :search, -> term {
    where("name like ? or form like ? or source like ?",
    "%#{term}%", "%#{term}%", "%#{term}%")
  }

  def self.to_csv(options = {})
    columns = [
      'name',
      'form',
      'source'
    ]

    CSV.generate(options) do |csv|
      header = [
        'Name',
        'Form',
        'Source'
      ]

      csv.add_row(header)

      all.each do |account|
        row = []
        row += [account.name]
        row += [account.form]
        row += [account.source]

        csv.add_row(row)
      end
    end
  end
end
