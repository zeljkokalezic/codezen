class ProblemsController < ApplicationController
  before_action :set_api_auth_token
  before_action :set_problem, only: [:show]

  def index
  end

  def show
  end

  private

  def set_problem
    @problem = Problem.find_by_id(params[:id])
  end
end
