class PlansController < ApplicationController
  def index
    @current_plans = Plan.where(owner: current_user.id, status: 0)
  end

  def create
    @plan = Plan.new(plan_params.merge!({owner: current_user.id}))
    @plan.save!
    @current_plans = Plan.where(owner: current_user.id, status: 0)
    respond_to do |f|
      f.js
    end
  end

  def destroy
    @plan = Plan.find params[:id]
    @plan.destroy!
    
    @current_plans = Plan.where(owner: current_user.id, status: 0)
  end

  def update
    @plan = Plan.find params[:id]
    @plan.update!(plan_params)

    @current_plans = Plan.where(owner: current_user.id, status: 0)
    respond_to do |f|
      f.js
    end
  end

  private
  def plan_params
    params.require(:plan).permit(:name, :start, :end)
  end
end
