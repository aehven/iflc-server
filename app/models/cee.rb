require 'csv'

class CeeSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :state,
             :animal,
             :vegetable,
             :mineral,
             :image_url

  def image_url
    #image_url has too many slashes, so squeeze them out, but then fix the
    #https:// which does need two of them.
    object.image_url.squeeze("/").gsub("https:/s", "https://s")
  end
end

class Cee < ApplicationRecord
  mount_uploader :image, CeeImageUploader

  enum state: {
    gas: 100,
    liquid: 200,
    mush: 300,
    solid: 400
  }, _prefix: true

  has_many :flavors, dependent: :destroy
  has_many :notes, dependent: :destroy

  # http://stackoverflow.com/a/21818014
  has_many :favorites, as: :favoritable

  default_scope {order(name: :asc)}

  scope :search, -> term {
    where("name like ? or state like ? ",
    "%#{term}%", "%#{term}%")
  }

  def self.to_csv(options = {})
    columns = [
      'name',
      'state',
      'animal',
      'vegetable',
      'mineral'
    ]

    CSV.generate(options) do |csv|
      header = [
        'Name',
        'State',
        'animal',
        'vegetable',
        'mineral'
      ]

      csv.add_row(header)

      all.each do |account|
        row = []
        row += [account.name]
        row += [account.state]
        row += [account.animal]
        row += [account.vegetable]
        row += [account.mineral]

        csv.add_row(row)
      end
    end
  end
end
