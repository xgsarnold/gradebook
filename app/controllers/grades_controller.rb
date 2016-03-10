class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  # GET /grades
  def index
    if session[:user_type] == "Teacher"
      teacher_session

    elsif session[:user_type] == "Student"
      student_session

    elsif session[:user_type] == "Parent"
      parent_session
    end
  end
  # GET /grades/1
  def show

  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to @grade, notice: 'Grade was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grades/1
  def update
    if @grade.update(grade_params)
      redirect_to @grade, notice: 'Grade was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grades/1
  def destroy
    @grade.destroy
    redirect_to grades_url, notice: 'Grade was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grade_params
      params.require(:grade).permit(:assignment_name, :grade, :student_id)
    end

    def teacher_session
      student_identity = Student.where(teacher_id: session[:user_id])
      @grades = Grade.where(student_id: student_identity)
    end

    def student_session
      @grades = Grade.where(student_id: session[:user_id])
    end

    def parent_session
      student_identity = Parent.find_by(id: session[:user_id]).student_id
      @grades = Grade.where(student_id: student_identity)
    end
end
