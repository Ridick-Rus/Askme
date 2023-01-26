class QuestionsController < ApplicationController
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]

  def create
    question_params = params.require(:question).permit(:body, :user_id)
    question_params[:author] = current_user

    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос создан!'
    else
      flash.now[:alert] = "Вы неправильно заполнили поле вопроса!"

      render :new
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    @question.update(question_params)

    redirect_to user_path(@question.user), notice: 'Сохранили вопрос!'
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удалён!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).first(10)
    @users = User.order(created_at: :desc).first(10)
  end

  def new
    @user = User.find_by(nickname: params[:nickname])
    @question = Question.new(user: @user)
  end

  def edit
  end

  def hide
    @question.hidden = true
    @question.save

    redirect_to questions_path
  end

  private

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
