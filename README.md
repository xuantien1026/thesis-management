# README

Management system for Computer Science department of HCM University of Technology

# Set up guide

## 1. Clone this repository to your machine

```
$ git clone https://github.com/xuantien1026/thesis-management.git
$ cd thesis-management
```

## 2. Install dependencies
### Install rbenv
Follow the instructions from this repository: https://github.com/rbenv/rbenv

Confirm installation:
```
$ rbenv --version
rbenv 1.2.0
```

### Install ruby

```
$ rbenv install
```

Confirm ruby has been installed successfully:

```
$ ruby --version
ruby 2.7.2
```

### Install node
Follow the instructions from this repository: https://github.com/nodenv/nodenv

Confirm installation:
```
$ nodenv --version
nodenv 1.4.0
```

Install node
```
$ nodenv install
```

Confirm installation
```
$ node --version
v12.13.0
```

### Install bundler (ruby library manager)
```
$ gem install bundler -v 2.1.4
```

Confirm installation
```
$ bundle --version
Bundler version 2.1.4
```

Install project libraries
```
$ bundle install
```

### Install postgres
Follow instruction from official PostgreSQL site: https://www.postgresql.org/

Confirm installation:
```
$ psql --version
psql (PostgreSQL) 14.0
```

Set up an admin account:
```
$ export ADMIN_EMAIL=your_email
$ export ADMIN_PASSWORD=your_password
```

Set up initial data:
```
$ rails db:create db:migrate db:seed
```

## 3. Start rails server
Start the application server
```
rails s
```

Go to `localhost:3000` on your favourite browser
