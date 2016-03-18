module LoginHelpers

  def signin(user)
    # this code mimics a user signin.
    request.session[:user_id] = user.id
  end
end
