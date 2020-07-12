class ApartmentsController < ApplicationController
  # add controller methods
  set :views, "app/views/apartments" 

  # See a list of all apartments 
  get '/apartments' do 
    @apartments = Apartment.all 
    erb :index 
  end 

  # Form to create a new apartment 
  get '/apartments/new' do 
    erb :new
  end 

  # See a single apartment 
  get '/apartments/:id' do 
    #binding.pry
    @apartment = current_apartment 
    erb :show 
  end


  # Create a new apartment
  post '/apartments' do 
    apartment = Apartment.create(params) 
    redirect "/apartments"
  end 

  # # Form to edit an existing apartment 
  # get '/apartments/:id/edit' do 
  #   @apartment = current_apartment
  #   erb :edit 
  # end 

  # # Edit an existing apartment 
  # patch '/apartments/:id/' do
  #   apartment = current_apartment
  #   apartment.update(address: params[:address])
  #   redirect "/apartments/#{apartment.id}"
  # end 

  # Delete an apartment 
  delete '/apartments/:id' do 
    apartment = current_apartment
    apartment.destroy
    redirect '/apartments'
  end 

  def current_apartment
    Apartment.find(params[:id])
  end 

end
