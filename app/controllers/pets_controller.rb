class PetsController < ApplicationController
  before_action :authenticate

  # GET /v1/pets/index
  def index
    authorize Pet
    render json: Pet.all
  end

  # GET /v1/pets/show
  def show
    #render json: Pet.find_by_name(params[:name])
    @pet = Pet.find_by_name(params[:name])
    if @pet
      render json: @pet, serializer: PetSerializer
    else
      head status: :not_found
    end
  end

  # POST /v1/pets/new
  def new
    @pet = Pet.new(pet_params.merge(:user => @current_user))

    if @pet.save
      render json: @pet, status: :created, location: @pet
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  # PUT /v1/pets/update
  def update
    @pet = Pet.find_by_name(pet_params[:name])
    authorize @pet

    if !@pet
      head status: :not_found
    else
      if @pet.update(pet_params)
        head :no_content
      else
        render json: @pet.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /v1/pets/delete
  def delete
    @pet = Pet.find_by_name(pet_params[:name])
    authorize @pet

    if !@pet
      head status: :not_found
    else
      if @pet.destroy
        head :no_content
      else
        render json: @pet.errors, status: :unprocessable_entity
      end
    end
  end


private
  helper_method :current_user
  def current_user
      @current_user
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.where(token: token).first
      unless @current_user
        head status: :unauthorized
        return false
      else
        return true
      end
    end
  end

  def pet_params
    params.require(:pet).permit(:name, :age, :breed, :sex, :user)
  end

end
