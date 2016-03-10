class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  # before_action :logged_in_as_teacher?

  # GET /parents
  def index
    logged_in_as_teacher?
    parent_identity = Student.find_by(teacher_id: session[:user_id]).id
    @parents = Parent.where(student_id: parent_identity)
    Student.where(teacher_id: session[:user_id])
  end

  # GET /parents/1
  def show
    logged_in_as_teacher?
  end

  # GET /parents/new
  def new
    logged_in_as_teacher?
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  def create
    logged_in_as_teacher?
    @parent = Parent.new(parent_params)

    if @parent.save
      redirect_to @parent, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parents/1
  def update
    if @parent.update(parent_params)
      redirect_to @parent, notice: 'Parent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /parents/1
  def destroy
    logged_in_as_teacher?
    @parent.destroy
    redirect_to parents_url, notice: 'Parent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def parent_params
      params.require(:parent).permit(:name, :email, :password, :student_id)
    end
end
