class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(:name => params[:owner][:name])
    params[:owner].each_pair{ |id, belongs| (id != :name && belongs == "on" ) && @owner.pets << Pet.find(id) }
    params[:pet][:name] && Pet.create(:name => params[:pet][:name], :owner => @owner)

    redirect to("/owners/#{@owner.id}")
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all

    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])

    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    @owner = Owner.find(params[:id])
    @owner.update(:name => params[:owner][:name])
    @owner.pets = []
    params[:owner].each_pair{ |id, belongs| (id != :name && belongs == "on") && @owner.pets << Pet.find(id) }
    !params[:pet][:name].empty? && (@pet = Pet.create(:name => params[:pet][:name], :owner => @owner))
  end
  
end