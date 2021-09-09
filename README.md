# GitScore

# Scoring Service

## Intro

This challenge is designed to allow you to demonstrate your ability to:

- create maintainable software
- construct a service which meets requirements
- evaluate options and make informed decisions
- show off a little bit (write code you're proud of)

## About

In this project we will be computing "score cards" for GitHub users based on a stream of events and providing one or more routes to surface this data.

Events and their importance (represented by a score) are presented here:

| Event Type | Points |
|------------|---|
| PushEvent  | 5 |
| PullRequestReviewCommentEvent | 4 |
| WatchEvent  | 3 |
| CreateEvent | 2 |
| Every other event | 1 |

## Usage (how to run your code)

Install Elixir and Erlang
> Versions 1.12.2 (Elixir) & 24.0.4 (Erlang) were used in this project
Once repo is pulled downed locally:
1. Run `cd git_score`
2. Run `mix deps.get`
3. You will need to get an access token from a github repository you have access to and insert in the `config/dev.exs` directory
```
# dev.exs
config :git_scoring, github_token: <Your Token Here>
```
4. Run `mix phx.server` & navigate to `http://localhost:4000`
5. Input the repo owner into the input field and the current git history will be tallyed up and the total score will be calculated based off the above ruberic.

I tried to not overengineer this and utilized the Tentacat Hex package and is `User.Events.list/2` function. There is support for large streams of data using Flow if there happens to be a very large amount
of user data that comes through the list operation. Another option that could've been utilized in this case would've been to implement a Supervisor and GenStage to utilize the `Tentacat.Hooks.create/4`
and broadcasting those events using Endpoint and a topic.

This project doesnt really showcase much visually but does reflect the data appropriately.
