module Api
  module V1
    class StudentsController < ApplicationController

      rescue_from ActiveRecord::RecordNotUnique, with: :error_not_unique
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::NotNullViolation, with: :error_nil_value

      # Get all students
			def index
				@students = Student.select(:id, :nome_estudante, :cpf, :data_nascimento, :telefone_celular, :genero, :tipo_pagamento).order("created_at DESC");
				render json: {status: "Success", message: "All students.", data: @students}, status: :ok
			end

      # Get student by id
      def show
        @student_id = params[:id]
        @student = Student.select(:id, :nome_estudante, :cpf, :data_nascimento, :telefone_celular, :genero, :tipo_pagamento).find(@student_id)
        render json: {status: "Success", message: "Student with ID: #{@student_id}.", data: @student}, status: :ok
      end

      # Create a new student
      def create
        params.require([:nome_estudante, :cpf, :genero, :tipo_pagamento])

        @student_data = params.permit(:nome_estudante, :cpf, :data_nascimento, :telefone_celular, :genero, :tipo_pagamento)

        # Create object
        @student = Student.new(@student_data)

        # Try to save the object into DB
        if @student.save
					render json: {status: "Success", message: "Student saved.", data: @student.as_json(only: [:id, :nome_estudante, :cpf, :data_nascimento, :telefone_celular, :genero, :tipo_pagamento])}, status: :ok
				else
					render json: {status: "Error", message: "Student not saved.", data: @student.errors}, status: :unprocessable_entity
        end
      end

      def error_not_unique
        render json: {status: "Error", message: "Student already exists."}, status: :conflict
      end

      def error_not_found
        render json: {status: "Error", message: "Student not found."}, status: :not_found
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