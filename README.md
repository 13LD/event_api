# Simple Event planning API

## Task
Create event management system for planning events (Rest).

User should be able to register in the system, create, read update and delete own
events. Event entity must contain information about time, place, purpose etc. In
addition, system should allow user to invite other users to the event and attach files to
the event. Also, each event should have discussion board so participants could
discuss event details etc.
After finishing task please upload source code to the github with documentation for
API endpoints

Other requirements:
● Don’t forget about data security​ (user can't get other's events if he’s not
invited)
● Prefered database - PostgreSql
● Provide following endpoints (in addition to listed above):
○ Get closest events ( parameterized with interval, example: GET
“/events?due={timestamp}” or “/events?interval=7d” )
○ Feed (latest changes of your events (comments, file additions) )
● Prefered security implementation - OAuth2
● Validations​ on fields (limited length of char input, event could be created only in
future)
● Unit/Integrations tests(optional)
● Dockerize application(optional)

