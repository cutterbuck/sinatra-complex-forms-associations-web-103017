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
    @pet = Pet.create(params[:pet])
    if params[:owner_name].empty?
      @pet.owner = Owner.find(params[:pet][:owner_id])
      @pet.save
    else
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
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

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet"]["name"])
    # binding.pry
    if params["owner_name"].empty?
      owner = Owner.find(params["owner"]["name"])
      @pet.owner_id = owner.id
    else
      owner = Owner.create(name: params["owner_name"])
      owner.pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
