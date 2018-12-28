class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    render(json: model.all)
  end

  def show
    render(json: resource)
  end

  private

  def resource
    model.find(params[:id])
  end

  def model
    controller_name = self.class.to_s.split('::').last
    controller_name.gsub('Controller', '').singularize.constantize
  end

  def render_404
    render(status: 404)
  end
end
