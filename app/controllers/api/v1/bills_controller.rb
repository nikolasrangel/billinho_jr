module Api
  module V1
    class BillsController < ApplicationController
      # Handle errors:
      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

      # Get all student's bills
      # GET /api/v1/students/:student_id/bills
      def index
        @student_id = params[:student_id]
			 
        @bills = Bill
        .joins(:enrollment)
        .where("student_id = ?", @student_id)
        .select(:id, :valor_fatura, :data_vencimento, :status, :enrollment_id, :student_id)

        if @bills.any?
          render json: {
            status: "Success", 
            message: "All bills from the student ID: #{@student_id}.", 
            data: @bills
          }, status: :ok
        else
          raise ActiveRecord::RecordNotFound
        end

			end

      # Get a specific bill for a specific student
      # GET /api/v1/students/:student_id/bills/:id
      def show
        @student_id = params[:student_id]
        @bill_id = params[:id]
        
        @bill = Bill
        .joins(:enrollment)
        .where("student_id = ?", @student_id)
        .select(:id, :valor_fatura, :data_vencimento, :status, :enrollment_id, :student_id)
        .find(@bill_id)

        if @bill
          render json: {
            status: "Success", 
            message: "Bill's ID: #{@bill_id} for the student's ID: #{@student_id}.", 
            data: @bill
          }, status: :ok
        end

      end

      # Update the bill's status
      # PATCH /api/v1/students/:student_id/bills/:id
      def update
        @bill_data = params.require(:bill).permit(:status)
        @student_id = params[:student_id]
        @bill_id = params[:id]

        @bill = Bill.find(@bill_id)

        if @bill.update(@bill_data)
          render json: {
            status: "Success", 
            message: "Updated status field for the bill's ID: #{params[:id]} from the student's ID: #{@student_id}.", 
            data: @bill.as_json(only: [:id, :valor_fatura, :data_vencimento, :status, :enrollment_id])
          }, status: :ok
        end

      end

      # Error handlers:

      def error_parameter_missing(error)
        render json: {
          status: "Error", 
          message: error
        }, status: :unprocessable_entity
      end

      def error_request
        render json: {
          status: "Error", 
          message: "Error in request syntax."
        }, status: :bad_request
      end

      def error_not_found
        render json: {
          status: "Error", 
          message: "Bill not found."
        }, status: :not_found
      end

    end
  end
end