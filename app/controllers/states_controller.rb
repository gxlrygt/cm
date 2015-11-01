class StatesController < ApplicationController
  respond_to :json

  def index
    @states = State.all
    respond_with(@states)
  end

  def counties
    @state = State.find(params[:id])
    respond_with(::OptimalBlueCounties.counties_for_state(@state.code))
  end

end