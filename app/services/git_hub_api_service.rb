class GitHubApiService
  def initialize(user, token)
    @user = user
    @token = token
  end

  def get_data
    private_repos = []
    public_repos = []
    repos = Github::Client::Repos.new oauth_token: @token
    repos.list.each do |repo|
      if repo['private']
        private_repos << set_repo_data(repo)
      else
        public_repos << set_repo_data(repo)
      end
    end
    return private_repos, public_repos
  end

  def get_repo_commits(repo, start_date, end_date)
      commits_data = []
      branches_info = {}
      begin
        commits = Github::Client::Repos::Commits.new oauth_token: @token
        branches = Github::Client::Repos::Branches.new oauth_token: @token
        branch_lists = branches.list user: @user.login, repo: repo

        branch_lists.body.each do |branch|
          branches_info["#{branch.name}".to_s] = []
          branch_commits = commits.list user: @user.login, repo: repo, start_date: start_date, end_date: end_date, sha: branch.name
          branch_commits.each do |comm|
            branches_info["#{branch.name}".to_s].push(set_commit_data(comm))
          end
        end
        commits_data.push(branches_info)
      rescue
        puts "==============TO DO (solve issue of repo with no commits)==========="
      end
      commits_data
    end

  private

    def set_repo_data(repo)
      get_repo_data(repo)
    end

    def get_repo_data(repo)
      { id: repo['id'], node_id: repo['node_id'],
        name: repo['name'], full_name: repo['full_name'],
        private: repo['private'], description: repo['description'] }
    end



    def set_commit_data(data)
      { name: data['commit']['committer']['name'],
        email: data['commit']['committer']['email'],
        date: data['commit']['committer']['date'],
        message: data['commit']['message'] }
    end
end