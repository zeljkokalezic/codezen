class V1::ProblemsController < V1::BaseController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def index
    json_response(Problem.all)
  end

  def create
    @problem = Problem.new(problem_params)

    if @problem.save
      json_response(@problem, :created)
    else
      json_response(@problem.errors.full_messages, :unprocessable_entity)
    end
  end

  def update
    if @problem.nil?
      json_response(nil, :not_found)
    else
      if @problem.update(problem_params)
        json_response(@problem)
      else
        json_response(@problem.errors.full_messages, :unprocessable_entity)
      end
    end
  end

  def destroy
    if @problem.present?
      @problem.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def set_problem
    @problem = Problem.find_by_id(params[:id])
  end

  def problem_params
    params.permit(:text, :user_id, :language_id, :function_name, :setup)
  end
end