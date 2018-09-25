module Api
  module V1
    class BillsController < ApplicationController

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

      def error_request
        render json: {status: "Error", message: "Error in request syntax."}, status: :bad_request
      end

    end
  end
end