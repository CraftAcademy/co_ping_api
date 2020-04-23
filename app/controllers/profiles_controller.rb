# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile

  def show
    render json: @profile, serializer: ProfileSerializer
  end

  def update
    if params['profile'].value?('')
      render json: { message: 'You can not update you profile with an empty field' }
    else
      params['profile'].keys.each { |attribute| update_profile(attribute) }
      render json: @profile, serializer: ProfileSerializer
    end
  end

  private

  def find_profile
    @profile = User.find(params[:id])
  end

  def update_profile(attribute)
    @profile.update("#{attribute}": params['profile'][attribute])
  end
end