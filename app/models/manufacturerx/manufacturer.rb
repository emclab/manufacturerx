module Manufacturerx
  class Manufacturer < ActiveRecord::Base
    attr_accessor :active_noupdate, :quality_system_name
    attr_accessible :active, :address, :cell, :contact_info, :fax, :last_updated_by_id, :main_product, :name, :phone, :quality_system_id, :short_name, 
                    :as => :role_new  
    attr_accessible :active, :address, :cell, :contact_info, :fax, :last_updated_by_id, :main_product, :name, :phone, :quality_system_id, :short_name, :quality_system_name,
                    :active_noupdate,
                    :as => :role_update
    attr_accessor :start_date_s, :end_date_s, :name_keyword_s, :contact_info_s, :quality_system_id_s, :active_s
    attr_accessible :start_date_s, :end_date_s, :name_keyword_s, :contact_info_s, :quality_system_id_s, :active_s,     
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
      
    validates_presence_of :name, :short_name
    validates :name, :short_name, :uniqueness => { :case_sensitive => false, :message => I18n.t('Must be unique!') }
    validates_numericality_of :quality_system_id, :greater_than => 0, :only_integer => true, :if => 'quality_system_id.present?' 
  end
end
