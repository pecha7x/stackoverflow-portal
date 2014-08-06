class UserController < ApplicationController
  def index
  end

  def get_questions
    not_errors = true
    questions = Rails.cache.fetch("following/#{params[:username]}", :expires_in => 15.minutes) do
      StackExchangeService.get_questions(params[:username])
    end
    not_errors = false unless questions

    render :json => { :not_errors => not_errors, :questions => questions }
  end
end
