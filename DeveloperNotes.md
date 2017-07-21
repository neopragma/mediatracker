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

Look at the file ```.envvars``` and change any values you need to change for your development environment. If you clone the repo as-is and use sqlite3 as your database system, you won't have to change anything. If you fork the project and give your version a different name, you might need to change the values of environment variables ```PROJECT_NAME``` and ```PROJECT_ROOT```. If you use a different database management system or you want to name your database differently, you'll need to change ```DATABASE_NAME``` and possibly ```DATABASE_URL```. You may also need to add user credentials, depending on how you set things up with your database management system. I'm using unsecured sqlite3 - no user credentials necessary. Because this is a cloud-deployed, self-contained solution that's built offline, there's no harm done if someone corrupts the database. There's no secret information in there, anyway.

To get started with development (assuming your personal workflow is similar to mine), start by navigating to the project root directory and sourcing the ```.envvars``` file to set the environment variables.

```shell
. .envvars
```

or

```shell
source .envvars
```

Next, run the script ```createdb``` to create a sqlite3 database file (or do whatever you need to do for the database system you're using, if it's not squlite3).

```shell
createdb
```

That script doesn't create any tables, it only creates an empty file. To load the database with test data, run the ```loaddb``` script.

```shell
loaddb
```

The ```loaddb``` script creates the ```logs/``` directory, creates tables, and loads the tables with some sample data.

## run specs

The default ```rake``` task clears all the data in the databse and invokes the standard Rspec ```spec``` task.

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
bundle exec cucumber
```
