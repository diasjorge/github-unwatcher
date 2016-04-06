# github-unwatcher

Tired of receiving notifications from too many repositories?

github-unwatcher can help. It will ignore notifications from all repositories you don't own and have not contributed.

## Installation

bundle install

## Usage

```
[OCTOKIT_API_ENDPOINT=https://YOUR_GITHUB_ENTERPRISE/api/v3] OCTOKIT_ACCESS_TOKEN=YOUR_PERSONAL_ACCESS_TOKEN UNWATCHER_LOGIN=YOUR_LOGIN bundle exec ruby unwatcher.rb
```
