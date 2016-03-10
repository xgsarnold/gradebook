class SessionsController < ApplicationController

  def new

  end

  def create
    teacher = Teacher.find_by_email(params[:email])
    student = Student.find_by_email(params[:email])
    parent = Parent.find_by_email(params[:email])

    if teacher && teacher.authenticate(params[:password])
      session[:user_id] = teacher.id
      session[:user_type] = "Teacher"
      redirect_to root_path, notice: "You have succesfully logged in!"

    elsif student && student.authenticate(params[:password])
      session[:user_id] = student.id
      session[:user_type] = "Student"
      redirect_to grades_path

    elsif parent && parent.authenticate(params[:password])
      session[:user_id] = parent.id
      session[:user_type] = "Parent"
      redirect_to grades_path
      
    else
      flash.now[:alert] = "Login failed: invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to login_path, notice: "You have logged out."
  end

end
