# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  def index
    if current_user
      @private_repos, @public_repos = GitHubApiService.new(current_user, session[:token]).get_data
    end
  end

  def repo_commmits
    if current_user
      # TO DO (check params present or not)
      data = GitHubApiService.new(current_user, session[:token]).get_repo_commits(params[:repo], params[:start_date], params[:end_date])
      render json: data
    end
  end
end
