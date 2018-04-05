

Installation
====================

First, go to https://genius-project.io and create new token: https://genius-project.io/en/dashboard/tokens

Install package
-------------------

Install genius-cli from repository::

    $ pip install genius-cli

Make sure genius is working::

    $ genius --help
    Usage: genius [OPTIONS] [APP]...

    Options:
      --auto       Generate and run migrations
      --src TEXT   Sources path
      --dst TEXT   Target path
      --name TEXT  Request name (for debug purposes)
      --help       Show this message and exit.


Configure
-----------------

Token should be placed in Environment variable GENIUS_TOKEN, for example in ~/.bash_profile::

    export GENIUS_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

You may need to reopen your terminal/reconnect, to reactivate your .bash_profile. Make sure new variable is here::

    $ env | grep GENIUS_TOKEN
    GENIUS_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Also it is useful sometimes to add GENIUS_FEATURES::

    export GENIUS_FEATURES=django

And the last thing that is already preconfigured, but maybe useful as well::

    export GENIUS_URL=https://genius-project.io/en/api/

Update package
------------------

UPdate genius-cli from repository::

    $ pip install -U genius-cli


