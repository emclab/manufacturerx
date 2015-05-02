require_dependency "manufacturerx/application_controller"

module Manufacturerx
  class ManufacturersController < ApplicationController
    before_action :require_employee
    
    def index
      @title = t('Manufacturers')
      @manufacturers = params[:manufacturerx_manufacturers][:model_ar_r].page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('manufacturer_index_view', 'manufacturerx')
    end
  
    def new
      @title = t('New Manufacturer')
      @manufacturer = Manufacturerx::Manufacturer.new()
      @erb_code = find_config_const('manufacturer_new_view', 'manufacturerx')
    end
  
    def create
      @manufacturer = Manufacturerx::Manufacturer.new(new_params)
      @manufacturer.last_updated_by_id = session[:user_id]
      if @manufacturer.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @erb_code = find_config_const('manufacturer_new_view', 'manufacturerx')
        flash[:notice] = t('Data Error. Manufacturer Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Manufacturer')
      @manufacturer = Manufacturerx::Manufacturer.find_by_id(params[:id])
      @erb_code = find_config_const('manufacturer_edit_view', 'manufacturerx')
    end
  
    def update
      @manufacturer = Manufacturerx::Manufacturer.find_by_id(params[:id])
      @manufacturer.last_updated_by_id = session[:user_id]
      if @manufacturer.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('manufacturer_edit_view', 'manufacturerx')
        flash[:notice] = t('Data Error. Manufacturer Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Manufacturer Info')
      @manufacturer = Manufacturerx::Manufacturer.find_by_id(params[:id])
      @erb_code = find_config_const('manufacturer_show_view', 'manufacturerx')
    end
    
    def autocomplete
      manufacturers = Manufacturerx::Manufacturer.where("active = ?", true).order(:name).where("name like ?", "%#{params[:term]}%")
      render json: manufacturers.map(&:name)    
    end  
    
    private
    
    def new_params
      params.require(:manufacturer).permit(:active, :address, :cell, :contact_info, :fax, :main_product, :name, :phone, :quality_system_id, :short_name)
    end
    
    def edit_params
      params.require(:manufacturer).permit(:active, :address, :cell, :contact_info, :fax, :main_product, :name, :phone, :quality_system_id, :short_name)
    end
  end
end
