class V1::GroupsController < ApplicationController

  before_action :authenticate_request_user

  def createGroup
    validate_parameters
    group = Group.new(group_params)
    group.owner = @current_user.id
    group.save
    if params[:members]
      params[:members].each do |m|
	user = User.where(id: m).last
	  if user
	    group.users << user
	  end
      end
    end
    render json: group, status: 201
  end


  def getGroups
    groups = @current_user.groups
    render json: groups
  end


  def updateGroup
    members = []
    group = Group.where(owner: @current_user.id).find(params[:id])
    if group.update(group_params)
      group.admins = params[:admins]
      group.save
      category = Lookup.where(category: "group_type",code: group.category).last
      group.users.each do |u|
        is_owner = group.owner == u.id ? true : false
        is_admin = (group.admins.include? "#{u.id}") ? true : false
        object = {
                id: u.id,
                name: "#{u.first_name} #{u.family_name}",
                photo: u.photo,
                is_owner: is_owner,
                is_admin: is_admin
                }
        members.push(object)
      end
      render json: group.attributes.merge(members: members,category_name: category.title,category_icon: category.icon,phto: group.photo)
    end
  end

  def getGroup
    members = []
    group = Group.find(params[:id])
    category = Lookup.where(category: "group_type",code: group.category).last
    group.users.each do |u|
      is_owner = group.owner == u.id ? true : false
      is_admin = (group.admins ? ((group.admins.include? "#{u.id}") ? true : false) : false)
      object = {
		id: u.id,
		name: "#{u.first_name} #{u.family_name}",
		photo: u.photo,
		is_owner: is_owner,
		is_admin: is_admin
		}
      members.push(object)
    end
    render json: group.attributes.merge(members: members,category_name: category.title,category_icon: category.icon,photo: group.photo)
  end



  private

  def group_params
    params.permit(:name,:description,:link,:is_private,:photo,:category,:admins=>[])
  end

  def validate_parameters
    true
  end
end
