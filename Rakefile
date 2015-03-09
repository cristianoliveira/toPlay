# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task "assets:precompile" do
    `(cd /tmp && curl -O https://heroku-buildpack-nodejs.s3.amazonaws.com/nodejs-0.8.19.tgz)`
    `(mkdir -p bin/nodejs && cd bin/nodejs && tar xzf /tmp/nodejs-0.8.19.tgz)`
    `(cd bin && ln -s nodejs/bin/node node)`
    `node bin/nodejs/bin/npm install`
end
