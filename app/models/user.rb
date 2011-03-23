#require 'digest/sha2'
require 'email_validator'

class User < ActiveRecord::Base
  include AgeGraphHelper
  include MapGraphHelper

  #validates_presence_of :login, :message => "Username is required"
  #validates_length_of :login, :minimum => 4, :maximum => 10, :too_short => "Username must be at least four characters long", :too_long => "Username must have 10 or fewer characters"
  #validates_uniqueness_of :login, :message => "Username already taken"

  #validate :password_must_be_present
  #validates_confirmation_of :password, :message => "Passwords do not match"

  #validates_numericality_of :zip_code, :message => "Zip code must be a number"
  #validates_length_of :zip_code, :is => 5, :message => "Invalid zip code length"

  #validates_numericality_of :birth_year, :message => "Year of birth must be a number"
  #validates_format_of  :birth_year, :with => /^(19|20)\d{2}$/ , :message => "Invalid year"

  #validates_presence_of :email, :message => "Email is required"
  #validates_length_of :email, :minimum => 5, :maximum => 80, :message => "Invalid email length"
  #validates :email, :email => true

  #validates :password, :presence => true, :confirmation => true, :length => {:within => 6..20}

  #attr_accessor :password_confirmation
  #attr_reader :password


  has_many :product_supports
  has_many :product_scans
  has_many :products, :through => :product_supports
  has_many :product_audits

  has_many :corporation_supports
  has_many :corporations, :through => :corporation_supports
  has_many :corporation_audits

  has_many :media_supports
  has_many :medias, :through => :media_supports
  has_many :media_audits

  has_many :government_supports
  has_many :governments, :through => :government_supports
  has_many :government_audits

  has_many :current_question_supports
  has_many :current_questions, :through => :current_question_supports

  after_create :add_default_products_to_user

  acts_as_authentic

  #Record a -1 (Cleared) vote for all default products.  This will cause the product to show up on newly created user screens
  def add_default_products_to_user
    Product.default_include.each do |product|
      ProductSupport.change_support product.id, self.id, -1
    end
  end
end
