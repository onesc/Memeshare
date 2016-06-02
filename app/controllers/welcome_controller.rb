class WelcomeController < ApplicationController
  def index

    @memb_assocs = UsersGroup.all
    @all_images = Image.all
    @images = []
  

      @all_images.each do |i|
        @groups_belong_to.each do |g|
          if i.group_id == g.id
            @images << i
          end
        end
      end

  end
end
