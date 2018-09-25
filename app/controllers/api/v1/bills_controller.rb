module Api
  module V1
    class BillsController < ApplicationController

      rescue_from ActionController::ParameterMissing, with: :error_parameter_missing
      rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

      # Get all bills
			def index
			  @bills = Bill.select(:id, :valor_fatura, :data_vencimento, :status, :enrollment_id).order("enrollment_id DESC");
			  render json: {status: "Success", message: "All bills.", data: @bills}, status: :ok
			end

      # Get bills for an specific enrollment id
      def show
        @enrollment_id = params[:id]
        
        @bill = Bill.where("enrollment_id = ?", @enrollment_id).select(:id, :valor_fatura, :data_vencimento, :status)

        if @bill.any?
          render json: {status: "Success", message: "Bills for the enrollment: #{@enrollment_id}.", data: @bill}, status: :ok
        else
          render json: {status: "Error", message: "Bills not found for this enrollment_id."}, status: :not_found
        end
      end

      # Update a specific bill by its ID
      def update
        @bill_data = params.require(:bill).permit(:status)

        @bill = Bill.find(params[:id])

        if @bill.update(@bill_data)
          render json: {status: "Success", message: "Updated status for the bill's ID: #{params[:id]}.", data: @bill.as_json(only: [:id, :valor_fatura, :data_vencimento, :status, :enrollment_id])}, status: :ok
        elsif
          render json: {status: "Error", message: @bill.errors}, status: :not_found
        end

      end

      def error_parameter_missing(error)
        render json: {status: "Error", message: error}, status: :unprocessable_entity
      end

      def error_request
        render json: {status: "Error", message: "Error in request syntax."}, status: :bad_request
      end

      def error_not_found
        render json: {status: "Error", message: "Bill's ID not found."}, status: :not_found
      end

    end
  end
end