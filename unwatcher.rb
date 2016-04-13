require 'octokit'

# OCTOKIT_API_ENDPOINT
# OCTOKIT_ACCESS_TOKEN
# UNWATCHER_LOGIN

def client
  @client ||= Octokit.client
end

def owner?(repo, login)
  repo[:owner][:login] == login
end

def contributor?(repo, login)
  contributors = client.contributors(repo.full_name)

  # When repo is empty list of contributors is an empty string, so user can not be contributor
  return false if contributors == ""

  contributors.any? { |contributor| contributor[:login]  == login }
end

login = ENV.fetch('UNWATCHER_LOGIN')

# stack = Faraday::RackBuilder.new do |builder|
#   builder.response :logger
#   builder.use Octokit::Response::RaiseError
#   builder.adapter Faraday.default_adapter
# end

# Octokit.middleware = stack

Octokit.auto_paginate = true

repos = client.repos

repos.each do |repo|
  if owner?(repo, login)
    puts "Owner for #{repo.full_name}"
    next
  end

  if contributor?(repo, login)
    puts "Contributor for #{repo.full_name}"
  else
    puts "Not a contributor for #{repo.full_name}. Not watching it anymore."
    client.delete_subscription(repo.full_name)
  end
end
