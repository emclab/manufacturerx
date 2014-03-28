require 'spec_helper'

module Manufacturerx
  describe Manufacturer do
    it "should be OK" do
      c = FactoryGirl.build(:manufacturerx_manufacturer)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:manufacturerx_manufacturer, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil short name" do
      c = FactoryGirl.build(:manufacturerx_manufacturer, :short_name => nil)
      c.should_not be_valid
    end
    
    it "should reject duplidate name" do
      p = FactoryGirl.create(:manufacturerx_manufacturer, :name => 'test')
      p1 = FactoryGirl.build(:manufacturerx_manufacturer, :name => 'Test', :short_name => 'a new short')
      p1.should_not be_valid
    end
    
    it "should reject duplidate short name" do
      p = FactoryGirl.create(:manufacturerx_manufacturer, :short_name => 'test')
      p1 = FactoryGirl.build(:manufacturerx_manufacturer, :short_name => 'Test', :name => 'a new short')
      p1.should_not be_valid
    end
    
    it "should accept nil quality_system_id" do
      c = FactoryGirl.build(:manufacturerx_manufacturer, :quality_system_id => nil)
      c.should be_valid
    end
    
    it "should not take non digital quality_system_id" do
      c = FactoryGirl.build(:manufacturerx_manufacturer, :quality_system_id => 'nil')
      c.should_not be_valid
    end
    
  end
end
