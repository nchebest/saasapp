class ProfilesController < ApplicationController
  # Get to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # Post to /users/:user_id/profile
  def create
    # Ensure we have the user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile ( profile_params )
    if @profile.save
      flash[:success] = "Profile Updated"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  # Get to /users/:user_id/profile/edit
  def edit
    # Ensure we are aditing current user profile
   @user = User.find( params[:user_id] )
   @profile = @user.profile
  end
  
  # Put to /users/:user_id/profile/update
  def update
    # Retrieve the user from their database
    @user = User.find( params[:user_id] )
    # Retrieve that user's profile
    @profile = @user.profile
    # Mass assign user edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated"
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :edit
    end
  end
  
  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
end