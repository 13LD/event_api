# Simple Event planning API
![build + tests](https://travis-ci.org/13LD/event_api.svg?branch=master)

## Task
Create event management system for planning events (Rest).
User should be able to register in the system, create, read update and delete own
events. Event entity must contain information about time, place, purpose etc. In addition, system should allow user to invite other users to the event and attach files to the event. Also, each event should have discussion board so participants could discuss event details etc.



### All Routes
![alt tag](https://s28.postimg.org/4uxoolw6l/2017_01_26_23_38_34.png)

#### Deployed on Heroku  
You can find deployed API at the following address:  https://apievent.herokuapp.com/auth/sign_in

### Authentication
> gem 'devise_token_auth'

Devise_token_auth provides an excellent authentication mechanism by taking care of user authentication, security and session management

### Feed

> gem 'public_activity'

This gem help to show all latest changes of events and users 
```Ruby 
  def index
    @invites = @user.all_following.unshift(@user)
    @activities = PublicActivity::Activity.where(owner_id: @invites).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: @activities

  end
```  
### Comments
Comment entity was implemented by this gem
> gem 'acts_as_commentable'

It help us to make commentable any entity 


### Invites
Invites was realized by gem 
> gem 'acts_as_follower'

It allows us to invite other users to your events 


### Attachment 
Attachment was implemented by carrierwave uploader.
> gem 'carrierwave'

it allows you to insert files using this attribute
```Ruby 
 mount_uploader :attachment, AttachmentUploader
```

### Events 
○ Get closest events ( parameterized with interval, example: GET /events?interval=7d )



#### Running the project with docker

This project relies on `docker-compose` for dependency management. You can find information
on how to install it [here](https://docs.docker.com/compose/install/).

When first running the app, or when changing the `Gemfile` or `docker-compose.yml` run:
```
docker-compose build
```

You can boot the app with:
```
docker-compose up
```

To run commands such as `rake` tasks or `rails` commands run:
```
docker-compose run web <your_command_and_arguments>
```

## Developing

While developing, keep checking the tests with:

```
docker-compose run web bundle exec rspec
```


### Usage 

Create Database

> rake db:migrate

To load data from factory from lib/task/populate.rake

> rake fill:data

To run tests 

> RAILS_ENV=test rake db:migrate 
> bundle exec rspec



Run server

> rails s 



