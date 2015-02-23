require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /manufacturerx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'quality_system')
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'manufacturerx_manufacturers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "Manufacturerx::Manufacturer.where(:active => true).order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'manufacturerx_manufacturers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'manufacturerx_manufacturers', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'manufacturerx_manufacturers', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login' 
    end
    it "works! (now write some real specs)" do
      sup = FactoryGirl.create(:manufacturerx_manufacturer, :quality_system_id => @qs.id)
      visit manufacturerx.manufacturers_path
      save_and_open_page
      expect(page).to have_content('Manufacturers')
      
      click_link 'Edit'
      expect(page).to have_content('Update Manufacturer')
      
      visit manufacturerx.manufacturers_path
      click_link sup.id.to_s     
      expect(page).to have_content('Manufacturer Info')
      
      visit manufacturerx.manufacturers_path
      #save_and_open_page
      click_link "New Manufacturer"
      #save_and_open_page
      expect(page).to have_content('New Manufacturer')
    end
  end
end
