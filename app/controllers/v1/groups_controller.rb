class V1::GroupsController < ApplicationController

  before_action :authenticate_user

  def createGroup
    validate_parameters
    group = Group.new(group_params)
    if @current_user.groups.build(group).save
	render json: group, status: 201
    else
        render json: group.errors, status: 422
    end
  end



  private

  def group_params
    params.permit(:name,:description,:link,:is_private, groups_photos_attributes: [:file])
  end

  def validate_parameters
    ""
  end
end
