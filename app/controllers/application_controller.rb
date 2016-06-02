class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

    before_action :fetch_user

    private
      def fetch_user
        @current_user = User.find_by(:id => session[:user_id]) if session[:user_id].present?
        session[:user_id] = nil unless @current_user.present?
        @groups = Group.all
        @groups_belong_to = []

          @groups.each do |g|
              UsersGroup.all.each do |mb|
                       if mb.user_id == session[:user_id] && mb.group_id == g.id
                         @groups_belong_to << g
                       end
               end
          end
      end
end
