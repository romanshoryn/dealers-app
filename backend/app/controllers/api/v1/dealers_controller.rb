# frozen_string_literal: true

class Api::V1::DealersController < ApplicationController
  def index
    scope = Dealer.offset(params[:offset]).limit(params[:limit])

    render json: {
      data: ActiveModelSerializers::SerializableResource.new(
        scope,
        each_serializer: DealerSerializer
      ),
      total_count: Dealer.count
    }
  end
end
