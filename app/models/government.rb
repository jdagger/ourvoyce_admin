class Government < ActiveRecord::Base
  include AgeGraphHelper
  include MapGraphHelper

  belongs_to :government_type
  has_many :government_supports
  has_many :users, :through => :government_supports
  has_many :government_audits
  belongs_to :state
  belongs_to :chamber

  def government_type_from_text text
    government_type_id = 0
    case text.downcase
    when 'agency'
      government_type_id = 1
    when 'executive'
      government_type_id = 2
    when 'legislative'
      government_type_id = 3
    end
    return government_type_id
  end


  class << self
    def government_lookup id
      begin
        return Government.find id
      rescue 
        return nil
      end
    end
  end
end
