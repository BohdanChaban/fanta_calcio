[![Build Status](https://travis-ci.org/BohdanChaban/fanta_calcio.svg?branch=master)](https://travis-ci.org/BohdanChaban/fanta_calcio)

[![Coverage Status](https://coveralls.io/repos/github/BohdanChaban/fanta_calcio/badge.svg?branch=master)](https://coveralls.io/github/BohdanChaban/fanta_calcio?branch=master)

[![Code Climate](https://codeclimate.com/github/codeclimate/codeclimate/badges/gpa.svg)](https://codeclimate.com/github/BohdanChaban/fanta_calcio)

# FANTA CALCIO

Web Rails application for Fantasy Football based on Seria A competition.

## Getting started
```
bundle
rake db:create
rake db:migrate
rake db:seed
rspec spec
```

## Project structure
- Club:
    - are created during project setup.
    - is filled with real players.
    - must be updated after each round of Seria A competition.
- Player:
    - are created during project setup.
- User:
    - after registration user must create `Team`.
    - after sign in user is redirected to `Team` screen.
    - user can have only one team.
- Team:
    - is forming from `clubs` `players`.
    - can have max 25 `players`:
        - 3 goalkeepers (P);
        - 8 defenders (D);
        - 8 midfielders (C);
        - 6 forwards (A).
- Tour:
    - round of Seria A competition.
    - contains with Seria A `games`.
- Game:
    - Seria A game between two `clubs` in some `tour`.
- Squad:
    - is exhibited by `user` one hour before `tour` start.
    - must have 11 `members` in main part:
         - 1 goalkeeper (P);
         - 3-5 defenders (D);
         - 3-5 midfielders (C);
         - 1-3 forwards (A).
    - must have 7 `members` in reserve part.
- Member:
    - is `player` which is in `squad`.
    - stored all results (points, bonuses etc.) of `player` in current `tour`.
