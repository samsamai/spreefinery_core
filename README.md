[Spree 1.3](http://spreecommerce.com/) has a fantastic pluggable authentication system. This gem configures Spree
to use the built in (Devise) authentication in [RefineryCMS](http://refinerycms.com/), and allows you to share
authentication between the two engines.

Gemfile:

```ruby
gem 'spreefinery_core', :git => 'git://github.com/shoponrails/spreefinery_core.git'
```
    
Run bundler, then install Spree

    bundle
    rails g spree:install
    
**Note:** The Spree installer will automatically copy and run a migration from this gem. If you want to copy
the migration manually, you can use the following command:

    rake railties:install:migrations FROM=spreefinery_core
    
Optionally put this line at the top of config/routes.rb to use RefineryCMS for your home page:

```ruby
root :to => "refinery/pages#home"
```

Start your application, and create a RefineryCMS user. You can then make yourself a Spree admin using the Rails console:

```ruby
rails console
> Refinery::User.first.spree_roles << Spree::Role.find_or_create_by_name("admin")
```
    
All done! You should now be able to access Refinery at [http://localhost:3000/refinery](http://localhost:3000/refinery) and Spree at [http://localhost:3000/admin](http://localhost:3000/admin).
