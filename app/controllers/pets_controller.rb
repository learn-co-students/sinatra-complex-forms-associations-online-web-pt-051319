class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all

    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @pets = Pet.all
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(:name => params[:pet][:name])
    # binding.pry
    @owner = !!params[:pet][:owner] ? Owner.find(params[:pet][:owner]) : Owner.create(:name => params[:owner][:name])
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    Owner.find(@pet.owner_id).pets.delete(@pet)
    @owner = !params[:owner][:name].empty? ? Owner.create(:name => params[:owner][:name]) : Owner.find(params[:pet][:owner])
    @pet.update(:name => params[:pet][:name], :owner => @owner)
    redirect to "pets/#{@pet.id}"
  end
end