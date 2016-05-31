class UsersGroupsController < ApplicationController
  enum member_type: {
   creator: 0,
   moderator: 1,
   member: 2,
   god: 3
 }
end
