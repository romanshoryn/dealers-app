# frozen_string_literal: true

class Api::V1::DealersController < ApplicationController
  def index
    render jsonapi: Dealer.all
  end
end
