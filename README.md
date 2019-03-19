# README.md

Car Insurance 

## Dependencies

- Ruby 2.3.5p376

## Setup

```
gem install bundler
bundle install
```


## Test Suite

### All

`rspec spec/*`

### `after-30-days` script

`rspec spec/after_30_days_test.rb`


## Docker

`docker build -t insurance-app .`
`docker run -i -t insurance-app:latest /bin/bash`

