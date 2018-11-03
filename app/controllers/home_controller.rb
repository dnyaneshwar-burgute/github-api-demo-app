# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  def index
    if current_user
      @private_repos, @public_repos = GitHubApiService.new(current_user, session[:token]).get_data
    end
  end

  def repo_commits
    if current_user
      # TO DO (check params present or not)
      data = GitHubApiService.new(current_user, session[:token]).get_repo_commits(params[:repo], params[:start_date], params[:end_date])
      @repo_and_data = {repo: params[:repo], data: data }
      respond_to do |format|
        format.html
        format.js { render layout: false, content_type: 'text/javascript' }
      end
    end
  end
end
