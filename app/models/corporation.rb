class Corporation < ActiveRecord::Base
  include AgeGraphHelper
  include MapGraphHelper

  has_many :corporation_supports
  has_many :users, :through => :corporation_supports
  has_many :corporation_audits

  class << self
    def corporation_lookup id
      begin
        return Corporation.find id
      rescue
        return nil
      end
    end

  end
end
