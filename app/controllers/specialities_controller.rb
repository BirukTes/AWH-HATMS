class SpecialitiesController < ApplicationController
  # Authorisation callbacks
  after_action(:verify_authorized)
  after_action(:verify_policy_scoped, only: :index)

  def new
    @speciality = policy_scope(Speciality)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
