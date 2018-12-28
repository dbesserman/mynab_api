module Api
  class GroupsController < ApplicationController
    def index
      groups = Group.all
      json = GroupSerializer.render(groups)
      render json: json
    end
  end
end
