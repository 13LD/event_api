# Simple Event planning API


## Task
Create event management system for planning events (Rest).
User should be able to register in the system, create, read update and delete own
events. Event entity must contain information about time, place, purpose etc. In addition, system should allow user to invite other users to the event and attach files to the event. Also, each event should have discussion board so participants could discuss event details etc.

### All Routes
![alt tag](https://s28.postimg.org/4uxoolw6l/2017_01_26_23_38_34.png)

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




Dockerize application haven't done yet :(
