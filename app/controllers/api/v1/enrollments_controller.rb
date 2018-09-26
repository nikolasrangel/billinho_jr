module Api
  module V1
    class EnrollmentsController < ApplicationController
      # Handle errors:
      rescue_from ActiveRecord::RecordNotUnique, with: :error_not_unique
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::NotNullViolation, with: :error_nil_value

      # Get all enrollments from a specific student ID
      # GET /api/v1/students/:student_id/enrollments
      def index
        @student_id = params[:student_id]
        @student_enrollments = Enrollment
          .where("student_id = ?", @student_id)
          .select(:id, :student_id, :institution_id, :nome_curso, :valor_total, :qtd_faturas)
          .order("created_at DESC");

			  render json: {
          status: "Success", 
          message: "All enrollments from the student's ID: #{@student_id}", 
          data: @student_enrollments
        }, status: :ok
			end

      # Get a specific enrollment from a specific student
      # GET /api/v1/students/:student_id/enrollments/:id
      def show
        @enrollment_id = params[:id]
        @student_id = params[:student_id]
        
        @enrollment = Enrollment
          .joins(:institution, :student)
          .where("enrollments.id = ? AND student_id = ?", @enrollment_id, @student_id)
          .select('nome AS nome_instituicao', :nome_curso, :valor_total, :qtd_faturas, :dia_vencimento, :id, :institution_id, :nome_estudante, :student_id)

        if @enrollment.any?
          render json: {
            status: "Success", 
            message: "Enrollment's ID: #{@enrollment_id} from the student's ID: #{@student_id}", 
            data: @enrollment
          }, status: :ok
        else
          raise ActiveRecord::RecordNotFound
        end

      end

      # Create a new enrollment to a specific student
      # POST /api/v1/students/:student_id/enrollments
      def create
        params.require([:valor_total, :qtd_faturas, :dia_vencimento, :nome_curso, :institution_id, :student_id])

        @enrollment_data = params
          .permit(:valor_total, :qtd_faturas, :dia_vencimento, :nome_curso, :institution_id, :student_id)

        # Create object
        @enrollment = Enrollment.new(@enrollment_data)

        #Try to save the object into DB
        if @enrollment.save
				  render json: {
            status: "Success", 
            message: "Enrollment saved.", 
            data: @enrollment.as_json(only: [:id, :valor_total, :qtd_faturas, :dia_vencimento, :nome_curso, :institution_id, :student_id])
          }, status: :ok
				else
				  render json: {
            status: "Error", 
            message: "Enrollment not saved.", 
            data: @enrollment.errors
          }, status: :unprocessable_entity
        end
        
      end

      # Error handlers:

      def error_not_unique
        render json: {
          status: "Error", 
          message: "Enrollment already exists."
        }, status: :conflict
      end

      def error_not_found
        render json: {
          status: "Error", 
          message: "Enrollment not found."
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