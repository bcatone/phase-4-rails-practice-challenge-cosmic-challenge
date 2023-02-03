class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_scientist_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_error_response

    def index
        render json: Scientist.all, status: :ok
    end

    def show
        render json: Scientist.find(params[:id]), include: ['planets'], status: :ok
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        scientist = Scientist.find(scientist_params)
        scientist.update(scientist_params)
        render json: scientist, status: :ok
    end

    def destroy
        Scientist.find(params[:id]).destroy
        #head {}, status: :no_content
    end


    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_scientist_not_found_response
        render json: { error: "Scientist not found" }, status: :not_found
    end

    def render_error_response(error)
        render json: { error: error.full_messages }, status: :unprocessable_entity
    end
end
