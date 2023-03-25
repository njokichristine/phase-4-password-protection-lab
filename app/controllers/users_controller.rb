
class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :error_handler
        def create
           if allowed_params[:password] == allowed_params[:password_confirmation]
           new_user = User.create(allowed_params)
           session[:user_id] = new_user[:id]
           render json: new_user 
           else 
            render json: {error: "Unprocessable entity"}, status:422
           end
        end
    
        def show
        logged_in_user  = User.find(session[:user_id])
        render json: logged_in_user
        end
    
        private
    
        def allowed_params
            params.permit(:id,:username, :password,:password_confirmation)
        end
    
        def error_handler
            render json: {error:"Unauthorized Request"}, status:401
        end
    end