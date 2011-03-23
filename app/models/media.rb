class Media < ActiveRecord::Base
  #set_table_name :medias
  include AgeGraphHelper
  include MapGraphHelper

  has_many :media_supports
  has_many :users, :through => :media_supports
  has_many :media_audits
  belongs_to :media_type
  has_many :children, :class_name => 'Media', :foreign_key => "parent_media_id"
  belongs_to :parent_media, :class_name => 'Media'

  class << self
    def media_lookup id
      begin
        return Media.find id
      rescue
        return nil
      end
    end


  end
end
