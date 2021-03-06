class User < ApplicationRecord
  acts_as_authentic

  include Authlogic::ActsAsAuthentic::EmailToken::Confirmation

  has_many :opening_hours
  has_many :payements
  has_many :restaurants
  has_many :menus
  has_many :dishes
  has_many :sections
  has_many :posts

  validates_uniqueness_of :email

  mount_uploader :picture, PictureUploader

  after_create :add_to_newsletter

  extend FriendlyId
  friendly_id :firstname, use: :slugged

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  SUPER_USER = 'a.rousseau@votre.restaurant'


  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

  # Create a unique number to generate a key to accross session between domain
  def public_login_key
    Digest::SHA1.hexdigest "#{self.crypted_password}_#{self.last_request_at}"
  end

  # Check if the user is premium
  def premium?
    return false unless self.premium_until
    return Time.now < self.premium_until
  end


  def paypal_url(return_path)
    values = {
      business: "merchant@gotealeaf.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: course.price,
      item_name: course.name,
      item_number: course.id,
      quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  # activate account from user email token
  #
  # Method imported from Authlogic::ActsAsAuthentic::EmailToken
  def activate
    self.activated = true
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver_now
  end

  def add_to_newsletter
    Newsletter.create({email: self.email})
  end

  def super_user?
    self.email == User::SUPER_USER
  end

  # Format to json_ld
  #
  # @return [Hash]
  def to_jsonld
    url = Rails.application.routes.url_helpers.user_url self.id, host: 'votre.restaurant'
    {
      "@context" => "http://schema.org/",
      "@type": "Person",
      givenName: self.lastname,
      url: url
    }
  end

end
