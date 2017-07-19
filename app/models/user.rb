class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :role, :address, :phone,
    :favorite_accounts

  def favorite_accounts
    object.favorites.where("favoritable_type = 'Account'")
  end
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
          # :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def token_validation_response
    # https://github.com/lynndylanhurley/devise_token_auth/issues/249
    UserSerializer.new( self, root: false ).as_json
  end

  enum role: {
    regular: 100,
    manager: 200,
    admin: 1000
  }

  # http://stackoverflow.com/a/21818014
  has_many :favorites, inverse_of: :user, dependent: :destroy

  scope :search, -> term {
    where("first_name like ? or last_name like ? or email like ?",
    "%#{term}%", "%#{term}%", "%#{term}%")
  }
end
