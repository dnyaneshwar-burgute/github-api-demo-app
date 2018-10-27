class GitHubApiService
  def initialize(user, token)
    @user = user
    @token = token
  end

  def get_data
    private_repos = []
    public_repos = []
    repos = Github::Client::Repos.new aouth_token: @token, user: @user.login
    repos.list.each do |repo|
      if repo['private']
        private_repos << set_repo_data(repo)
      else
        public_repos << set_repo_data(repo)
      end
    end
    return private_repos, public_repos
  end

  private

    def set_repo_data(repo)
      repo_data = get_repo_data(repo)
      commits = get_repo_commits(repo_data)
      repo_data.merge!({commits: commits})
    end

    def get_repo_data(repo)
      { id: repo['id'], node_id: repo['node_id'],
        name: repo['name'], full_name: repo['full_name'],
        private: repo['private'] }
    end

    def get_repo_commits(repo)
      commits_data = []
      commits = Github::Client::Repos::Commits.new aouth_token: @token
      lists = commits.list user: @user.login, repo: repo[:name], sha: 'master'
      lists.each do |commit|
        commits_data << set_commit_data(commit)
      end
      commits_data
    end

    def set_commit_data(data)
      { name: data['commit']['committer']['name'],
        email: data['commit']['committer']['email'],
        date: data['commit']['committer']['date'],
        message: data['commit']['message'] }
    end
end