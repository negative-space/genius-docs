Basics
========================

In this tutorial we will create basic django app structure and learn couple useful commands.

First create hotel.col file::

    #hotel
    -----------
    name
    location

"col" file is a file that describes models & pages of our application.

Clo file we just created, describes django model, with name "hotel" and two text fields: name and location.

Django project
---------------

Generate django application structure and install dependencies required::

    $ genius --with django --install

"--with django" means, generate django files
"--install", means run "pip install -r requirements.txt"

Now file-structure is following:

.. image:: /img/gen_1_1.png
    :width: 200px

Migrations
----------------

Now we need migrations to create database structure. We can generate migrations now::

    $ python manage.py makemigrations hotel

    Migrations for 'hotel':
      hotel/migrations/0001_initial.py
        - Create model Hotel

    $ python manage.py migrate

    Operations to perform:
      Apply all migrations: admin, auth, contenttypes, hotel, sessions
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
      Applying hotel.0001_initial... OK
      Applying sessions.0001_initial... OK

There is another way to generate migrations quicker, but first lets unapply & remove all the migrations::

    $ genius --remove hotel

    Unapplying migrations
    Operations to perform:
      Unapply all migrations: hotel
    Running migrations:
      Rendering model states... DONE
      Unapplying hotel.0001_initial... OK
    Removing migrations

Easier way to generate & run migrations
-------------------------------------------

There is special flag "--auto" that runs in a row three commands:

#. genius
#. python manage.py makemigrations
#. python manage.py migrate

You can use flag --auto, when you changed something in models::

    $ genius --auto

    Application hotel
    hotel
    Migrations for 'hotel':
      0001_initial.py:
        - Create model Hotel
    Operations to perform:
      Apply all migrations: hotel
    Running migrations:
      Rendering model states... DONE
      Applying hotel.0001_initial... OK

.. note::
    Starting from this moment, every time we change something in *hotel.col* we will execute *genius --auto* command.


Lazines level80
-------------------------------------------

--up option is shortcut for::

    $ genius --with django --auto --install --watch --run

It will:

- generate django files
- create & run migrations
- install dependencies
- run django
- watch for changes in col files and execute "Generate & restart django"


Watching for changes
-----------------------

And for completely lazy bones there is a --watch flag::

    $ genius --auto --watch

    genius --auto --watch
    Watching for changes...
    Migrations for 'hotel':
      hotel/migrations/0002_hotel_stars.py
        - Add field stars to hotel
    Operations to perform:
      Apply all migrations: hotel
    Running migrations:
      Applying hotel.0002_hotel_stars... OK
    Generating ...ok.

Watch flag works with any combination of other genius flags.

Admin panel
--------------

Now let's add admin to our collection::

    #hotel
    -----------
    name
    location

    @admin

Now we can run app and check our admin panel:

.. image:: /img/gen_2.png
    :width: 80%

Yeah, that easy. @admin tag will register default admin that we will tweak in a moment.


Let's add couple hotels:

.. image:: /img/gen_3.png
    :width: 80%


After adding hotels, you will see that, our hotel list looks not too friendly:

.. image:: /img/gen_4.png
    :width: 80%


Let's fix it::

    #hotel
    -----------
    =name
    location

    @admin


"=" modifier says, that this field will be used as *name* of object. Now it's already better:

.. image:: /img/gen_5.png
    :width: 80%



Another thing we can do, is to specify what fields to show in admin list::

    #hotel
    -----------
    =name
    location

    @admin {
        list: *
    }

.. note::
    Parser is very tolerant, so we can format declaration as needed, ex. inline::

        @admin {list: *}

    Also we can add excluded fields::

        @admin {list: *, ^name}

    Or just enumerate field names::

        @admin {list: name, location}

Now it looks a way better:

.. image:: /img/gen_6.png
    :width: 80%


Relations
---------------

Now let's add rooms to our hotel::

    #room
    -----------
    =name
    max_people: int

    @admin {list: *}


    #hotel
    -----------
    =name
    location
    rooms: many(#room)

    @admin {list: *}

As usually, generator will do all the dirty work for us::

    $ genius --auto

    Application hotel
    Migrations for 'hotel':
      0002_auto_20170524_1856.py:
        - Create model Room
        - Add field rooms to hotel
    Operations to perform:
      Apply all migrations: hotel
    Running migrations:
      Rendering model states... DONE
      Applying hotel.0002_auto_20170524_1856... OK


Now our hotel editing form has field for rooms:

.. image:: /img/gen_7.png
    :width: 80%

If you click on this small "+" sign next to rooms field, popup for adding new room will be shown.

Now our list shows rooms as well, but doesn't look nice:

.. image:: /img/gen_8.png
    :width: 80%

Let's remove it from list::

    ...

    #hotel
    -----------
    =name
    location
    rooms: many(#room)

    @admin {list: *, ^rooms}


Another thing we can do, is to move location into separate model. First let's remove location field::

    #room
    -----------
    =name
    max_people: int

    @admin {list: *}


    #hotel
    -----------
    =name
    rooms: many(#room)

    @admin {list: *, ^rooms}

And then execute *gen --auto* as usually::

    $ genius --auto

Now let's add new model and field::

    #room
    -----------
    =name
    max_people: int

    @admin {list: *}


    #hotel
    -----------
    =name
    rooms: many(#room)

    @admin {list: *, ^rooms}

.. note::
    Always remove and then add back fields if field change data type.

After that two-step manipulation we have separate table for locations.


Rest API
----------------

Next step is to create Rest API.

Let's say we need to have api for looking hotels by location::

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

Then if we open `http://127.0.0.1:8000/api/` we will see two new apis added:


.. image:: /img/rest_1.png
    :width: 80%

.. image:: /img/rest_2.png
    :width: 80%

.. image:: /img/rest_3.png
    :width: 80%
