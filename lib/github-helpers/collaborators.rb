#require "rubygems"
#require "bundler/setup"
require "github_api"
require "highline/import"

module GithubHelpers
  class Collaborators
    attr_reader :github, :username, :repos

    def initialize(username, password)
      @username = username
      @github = Github.new(login:@username, password:password)
    end

    def repos(*repo_names)
      return @repos if @repos
      repos = @github.repos.list(:per_page=>120)
      @repos = repos.nil? ? repos : repos.select{|r| repo_names.flatten.include?(r.name)}
    end

    def review_sources
      repos.select{|r| r.name =~ /review_source/}
    end

    def add_collaborators(*collaborators, collection)
      collection = collection ||= self.repos
      collection.each do |repo|
        collaborators.flatten.each do |collaborator|
          @github.repos.collaborators.add(@username, repo.name, collaborator)
          puts "Adding #{collaborator} to #{repo.name}"
        end
      end
    end

    def remove_collaborators(*collaborators, collection)
      collection.each do |repo|
        collaborators.flatten.each do |collaborator|
          @github.repos.collaborators.remove(@username, repo.name, collaborator)
          puts "Removed #{collaborator} to #{repo.name}"
        end
      end
    end

    def unique_collaborators(collection=repos)
      collaborators = []
      collection.each do |repo|
        collaborators << @github.repos.collaborators.list(@username, repo.name)
      end
      collaborators.uniq
    end
  end
end
