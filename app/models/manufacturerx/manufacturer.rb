module Manufacturerx
  class Manufacturer < ActiveRecord::Base
    attr_accessor :active_noupdate
    attr_accessible :active, :address, :cell, :contact_info, :fax, :last_updated_by_id, :main_product, :name, :phone, :quality_system_id, :short_name,
                    :as => :role_new  
    attr_accessible :active, :address, :cell, :contact_info, :fax, :last_updated_by_id, :main_product, :name, :phone, :quality_system_id, :short_name,
                    :active_noupdate,
                    :as => :role_update
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :quality_system, :class_name => 'Commonx::MiscDefinition'
      
    validates_presence_of :name, :short_name
    validates :name, :short_name, :uniqueness => { :case_sensitive => false, :message => I18n.t('Must be unique!') }
    validates_numericality_of :quality_system_id, :greater_than => 0, :only_integer => true, :if => 'quality_system_id.present?' 
  end
end
