class TenantsController < ApplicationController
  # add controller methods
  set :views, "app/views/tenants" 

  #See a list of all tenants 
  get '/tenants' do 
    @tenants = Tenant.all 
    erb :index 
  end 


  # See a single tenant 
  get '/tenants/:id' do 
    @tenant = current_tenant 
    erb :show 
  end

  
    # Form to create a new tenant 
    get '/tenants/new' do 
    @apartments = Apartment.all
    erb :new
  end 
  
  # Create a new tenant
  post '/tenants' do 
    tenant = Tenant.new(params[:tenant])
    if !params[:tenant][:name].empty? 
      new_tenant = Apartment.create(params[:tenant]) 
      tenant.apartment = new_tenant
    end 
    tenant.save
    redirect "/tenants/#{tenant.id}"
  end 

  # Form to edit an existing tenant 
  get '/tenants/:id/edit' do 
    @tenant = current_tenant
    @apartments = Apartment.all
    erb :edit 
  end 

  # Update an existing tenant 
  patch '/tenants/:id/' do
    tenant = current_tenant
    tenant.update(params[:tenant])

    unless params[:apartment][:address].empty? 
      new_tenant = Apartment.create(params[:apartment]) 
      tenant.update(apartment_id: new_tenant.id)
    end 

    redirect "/tenants/#{tenant.id}"
  end 

  # Delete an existing tenant 
  delete 'tenants/:id' do 
    tenant = current_tenant
    tenant.destroy
    redirect '/tenants'
  end 

  def current_tenant
    #binding.pry
    Tenant.find(params[:id])
  end 

end
