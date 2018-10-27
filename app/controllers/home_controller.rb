# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  def index
    if current_user
      @private_repos, @public_repos = GitHubApiService.new(current_user, session[:token]).get_data
      byebug
    end
  end
end
