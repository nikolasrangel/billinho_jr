module Api
  module V1
    class InstitutionsController < ApplicationController
      # Handle errors:
      rescue_from ActiveRecord::RecordNotUnique, with: :error_not_unique
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::NotNullViolation, with: :error_nil_value

      # Get all institutions
      # GET /api/v1/institutions
			def index
			  @institutions = Institution.select(:id, :nome, :cnpj, :tipo).order("created_at DESC");
			  render json: {
          status:"Success", 
          message:"All institutions.", 
          data:@institutions
        }, status: :ok
			end

      # Get institution by id
      # GET /api/v1/institutions/:id
      def show
        @institution_id = params[:id]
        @institution = Institution.find(@institution_id)
        render json: {
          status: "Success", 
          message:"Institution with ID: #{@institution_id}.", 
          data: @institution.as_json(only: [:id, :nome, :cnpj, :tipo])
        }, status: :ok
      end

      # Create institution(s)
      # POST /api/v1/institutions
      def create
        params.require([:nome, :cnpj, :tipo])

        @institution_data = params.permit(:nome, :cnpj, :tipo)

        # Create object
        @institution = Institution.new(@institution_data)

        # Try to save the object into DB
        if @institution.save
				  render json: {
            status: "Success", 
            message: "Institution saved.", 
            data: @institution.as_json(only: [:id, :nome, :cnpj, :tipo])
          }, status: :created
				else
				  render json: {
            status: "Error", 
            message: "Institution not saved.", 
            data: @institution.errors
          }, status: :unprocessable_entity
        end
        
      end

      # Error handlers:
      
      def error_not_unique
        render json: {
          status: "Error", 
          message: "Institution already exists."
        }, status: :conflict
      end

      def error_not_found
        render json: {
          status: "Error", 
          message: "Institution not found."
        }, status: :not_found
      end

      def error_parameter_missing(error)
        render json: {
          status: "Error", 
          message: error
        }, status: :unprocessable_entity
      end

      def error_nil_value(error)
        render json: {
          status: "Error", 
          message: "The parameter(s) can not be null."
        }, status: :unprocessable_entity
      end

      def error_request
        render json: {
          status: "Error", 
          message: "Error in request syntax."
        }, status: :bad_request
      end

    end
  end
end