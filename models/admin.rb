class Admin
  include Mongoid::Document
  include Shield::Model

  field :email
  field :crypted_password

  def self.fetch(email)
    admin = where(email: email).first
    return admin
  end
end