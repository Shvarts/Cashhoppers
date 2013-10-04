class CustomDevise::SessionsController < Devise::SessionsController
   def create
     user = User.find_by_email(params[:user][:email])
     if !user.nil? && !user.deleted
      super
     else
       redirect_to new_user_session_path, :notice =>'bad login or password'
     end
   end

   def new
     super
   end
end
