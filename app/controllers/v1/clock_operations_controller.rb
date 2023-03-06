class V1::ClockOperationsController < ApplicationController
  include ClockOperationsCache

  def index
    render json: fetch_clock_operations
  end

  def create
    clock_operation = ClockOperation.create(clock_operation_params)
    if clock_operation.valid?
      render json:{data:"successfully created clock operation"}, status: :created
    else
      render json: {error: {status: 422, message: clock_operation.errors.full_messages}}, status: :unprocessable_entity
    end
  end


  private

  def clock_operation_params
    params.require(:clock_operation).permit(:clock_at)
  end
end