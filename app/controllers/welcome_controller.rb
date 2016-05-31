class WelcomeController < ApplicationController
  def index
    @groups = Group.all
    @memb_assocs = UsersGroup.all
  end
end
