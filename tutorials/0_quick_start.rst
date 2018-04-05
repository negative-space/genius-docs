Quick start
========================

Create hotel.col file::

    #room
    -----------
    =name

    @rest
    @admin

    #hotel
    -----------
    =name
    location: one(#location -> hotels)
    rooms: many(#room)

    @admin {list: *, ^rooms}
    @rest {
        fields: *
        inline: rooms(fields: *), location(fields: *, ^hotels)
    }

    #location
    -----------
    =name

    @admin {list: name}
    @rest {
        fields: *
        inline: hotels(
            fields: *, ^location
            inline: rooms(
                fields: *
            )
        )
    }

Run genius in fully-automatic mode::

    $ genius --up

    Watching for changes...
    Requirement already satisfied: django in /Users/alex/.virtualenvs/tutor/lib/python3.6/site-packages (from -r requirements.txt (line 1))
    Requirement already satisfied: djangorestframework in /Users/alex/.virtualenvs/tutor/lib/python3.6/site-packages (from -r requirements.txt (line 2))
    Requirement already satisfied: pytz in /Users/alex/.virtualenvs/tutor/lib/python3.6/site-packages (from django->-r requirements.txt (line 1))
    Migrations for 'hotels':
      hotels/migrations/0001_initial.py
        - Create model Hotel
        - Create model Location
        - Create model Room
        - Add field location to hotel
        - Add field rooms to hotel
    Operations to perform:
      Apply all migrations: admin, auth, contenttypes, hotels, sessions
    Running migrations:
      Applying contenttypes.0001_initial... OK
      Applying auth.0001_initial... OK
      Applying admin.0001_initial... OK
      Applying admin.0002_logentry_remove_auto_add... OK
      Applying contenttypes.0002_remove_content_type_name... OK
      Applying auth.0002_alter_permission_name_max_length... OK
      Applying auth.0003_alter_user_email_max_length... OK
      Applying auth.0004_alter_user_username_opts... OK
      Applying auth.0005_alter_user_last_login_null... OK
      Applying auth.0006_require_contenttypes_0002... OK
      Applying auth.0007_alter_validators_add_error_messages... OK
      Applying auth.0008_alter_user_username_max_length... OK
      Applying auth.0009_alter_user_last_name_max_length... OK
      Applying hotels.0001_initial... OK
      Applying sessions.0001_initial... OK
    Generating ...ok.
    Starting django...
    Performing system checks...

    System check identified no issues (0 silenced).
    April 05, 2018 - 20:41:29
    Django version 2.0.4, using settings 'app.settings'
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C


Go to "http://127.0.0.1:8000/api/" and "http://127.0.0.1:8000/admin/" to see results.

.. note::

    Result of generation is usual django app, so you can run it with "python manage.py runserver" as well.


