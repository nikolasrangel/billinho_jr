module Api
  module V1
    class InstitutionsController < ApplicationController

      rescue_from ActiveRecord::RecordNotUnique, with: :error_not_unique
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::NotNullViolation, with: :error_nil_value

      # Get all institutions
			def index
				@institutions = Institution.select(:id, :nome, :cnpj, :tipo).order("created_at DESC");
				render json: {status:"Success", message:"All institutions.", data:@institutions}, status: :ok
			end

      # Get institution by id
      def show
        @institution_id = params[:id]
        @institution = Institution.find(@institution_id)
        render json: {status: "Success", message:"Institution with ID: #{@institution_id}.", data:@institution}, status: :ok
      end

      # Create a new institution
      def create
        params.require([:nome, :cnpj, :tipo])

        @institution_data = params.permit(:nome, :cnpj, :tipo)

        # Create object
        @institution = Institution.new(@institution_data)

        # Try to save the object into DB
        if @institution.save
					render json: {status: "Success", message: "Institution saved.", data: @institution.as_json(only: [:id, :nome, :cnpj, :tipo])}, status: :ok
				else
					render json: {status: "Error", message: "Institution not saved.", data: @institution.errors}, status: :unprocessable_entity
        end
        
      end

      # arrumar o codigo do erro
      def error_not_unique
        render json: {status: "Error", message: "Institution already exists."}, status: :unprocessable_entity
      end

      # arrumar o codigo do erro
      def error_not_found
        render json: {status: "Error", message: "Institution not found."}, status: :unprocessable_entity
      end

      def error_parameter_missing(error)
        render json: {status: "Error", message: error}, status: :unprocessable_entity
      end

      def error_nil_value(error)
        render json: {status: "Error", message: "The parameter(s) can not be null."}, status: :unprocessable_entity
      end

      def error_request
        render json: {status: "Error", message: "Error in request syntax."}, status: :bad_request
      end

    end
  end
end