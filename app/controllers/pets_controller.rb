class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params['owner']['name'])
      @owner.save
      @pet = Pet.create(params["pet"])
      @owner.pets << @pet 
      @pet.owner = @owner 
    else 
      @pet = Pet.create(params["pet"])
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params['pet']['name']
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params['owner']['name'])
      @owner.save
      @pet = Pet.create(params["pet"])
      @owner.pets << @pet 
      @pet.owner = @owner 
    end
    redirect to "pets/#{@pet.id}"
  end
end

