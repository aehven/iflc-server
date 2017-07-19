require 'csv'

class AccountSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :phone,
             :fax,
             :email,
             :website,
             :street,
             :city,
             :state,
             :zip,
             :kind,
             :om,
             :fd1,
             :fd2,
             :rc,
             :referrer
end

class Account < ApplicationRecord
  include HasKind

  enum referrer: {
    MA: 100,
    Provider: 200,
    RC: 300,
    FD: 400,
    Other: 1000
  }, _prefix: true

  has_many :contacts, dependent: :destroy
  has_many :activities, dependent: :destroy

  # http://stackoverflow.com/a/21818014
  has_many :favorites, as: :favoritable

  default_scope {order(name: :asc)}

  scope :search, -> term {
    where("name like ? or phone like ? or email like ? or street like ? or city like ? or zip like ?",
    "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
  }

  def self.to_csv(options = {})
    columns = [
      'name',
      'phone',
      'fax',
      'email',
      'website',
      'street',
      'city',
      'state',
      'zip',
      'kind',
      'om',
      'fd1',
      'fd2',
      'rc',
      'contacts'
    ]

    CSV.generate(options) do |csv|
      header = [
        'Name',
        'Phone',
        'Fax',
        'Email',
        'Website',
        'Street',
        'City',
        'State',
        'Zip',
        'Kind',
        'Office Manager',
        'FD1',
        'FD2',
        'RC',
        'Contacts'
      ]

      csv.add_row(header)

      all.each do |account|
        row = []
        row += [account.name]
        row += [account.phone]
        row += [account.fax]
        row += [account.email]
        row += [account.website]
        row += [account.street]
        row += [account.city]
        row += [account.state]
        row += [account.zip]
        row += [account.kind]
        row += [account.om]
        row += [account.fd1]
        row += [account.fd2]
        row += [account.rc]
        row += [account.contacts.map(&:name)]

        csv.add_row(row)
      end
    end
  end
end
