class V1::GroupsController < ApplicationController

  before_action :authenticate_request_user

  def createGroup
    validate_parameters
    group = Group.new(group_params)
    @current_user.groups << group
    render json: group, status: 201
  end


  def getGroups
    render json: @current_user.groups
  end


  def updateGroup
    group = @current_user.groups.find(params[:id])
    if group.update(group_params)
      render json: group
    end
  end



  private

  def group_params
    params.permit(:name,:description,:link,:is_private, groups_photos_attributes: [:file])
  end

  def validate_parameters
    true
  end
end
