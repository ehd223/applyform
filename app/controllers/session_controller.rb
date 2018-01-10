class SessionController < ApplicationController
    def new
    end

    def create
        admin = Admin.find_by(name: params[:name])
        # If the user exists AND the password entered is correct.
        if admin && admin.authenticate(params[:password])
            # Save the user id inside the browser cookie. This is how we keep the user
            # logged in when they navigate around our website.
            session[:admin_id] = admin.id
            flash[:success]="Login Successful"
            redirect_to '/adminviewer'
        else
        # If user's login doesn't work, send them back to the login form.

            flash[:warning]="Invalid name/password combination"
            render 'new'
        end
    end

    def destroy
        session[:admin_id] = nil
        redirect_to '/'
    end
end
