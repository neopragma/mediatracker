# mediatracker - developer notes

## stack

* Ruby - programming language
* Bundler - dependency manager
* Rake - build tool
* Rack - start server
* Rspec - unit test framework
* Sinatra - web framework
* Sqlite3 - database management system
* Cucumber - acceptance test framework

## development platforms

Ubuntu Linux 16.04 or later. Has not been used on any other platform. In principle, you should be able to work with it on any platform that supports Ruby. Principles are nice, aren't they?

## setup

Look at the file ```.envvars``` and change any values you need to change for your development environment.

To get started with development (assuming your personal workflow is similar to mine), start by navigating to the project root directory and sourcing the ```.envvars``` file to set the environment variables.

```shell
. .envvars
```

or

```shell
source .envvars
```

Install dependencies with ```bundler```. If you don't already have ```bundler``` on your development system, install it with ```gem install bundler``` or whatever ruby version manager you may be using (such as ```rvm``` or ```rbenv```). Then use ```bundler``` to install dependencies.

```shell
bundle install --path vendor
```

Next, create the database. There's a ```rake``` task for that. The sqlite3 database is a single file. Its name depends on the setting of environment variable ```RAKE_ENV```. Accordingly the database filename could be:

* db/mediatracker-development
* db/mediatracker-test
* db/mediatracker-staging
* db/mediatracker-production

```shell
bundle exec rake reset_db
```

That task creates a database file and creates the tables, but doesn't load any content. There is no need to pre-load the database to run ```rspec``` tests. If you want to load the database with predefined test data, run the ```loaddb``` script or the ```rake``` task ```load_db```. The cukes depend on pre-loaded, known test data. The ```rake``` task ```cukes``` will load the database, but the task ```cucumber``` will not. You can also load the test data with the following ```rake``` task:

```shell
bundle exec rake load_db
```

## run specs

The default ```rake``` task clears all the data in the database and invokes the standard Rspec ```spec``` task.

```shell
bundle exec rake
```

## run cukes

The cukes need the services to be active. For local testing, you can run ```rackup``` to start a server on ```localhost:9292```.

```shell
rackup
```

Then you can execute the cukes through Bundler.

```
bundle exec rake cukes
```
