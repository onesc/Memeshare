class WelcomeController < ApplicationController
  def index
    @groups = Group.all
    @memb_assocs = UsersGroup.all

    @images = []
    @groups_belong_to = []

      @groups.each do |g|
          UsersGroup.all.each do |mb|
                   if mb.user_id == session[:user_id] && mb.group_id == g.id
                     @groups_belong_to << g
                            unless Image.where(group_id: g.id).to_a.first == nil
                                @images << Image.find(Image.where(group_id: g.id).to_a.first.id)
                            end
                   end
           end
      end
  end
end
