Variables
###########

As you already know, variables are just set of values that will available in template:

.. code-block:: col
    :caption: views.py

    [index: /]
    foo: "hello"
    boo: 123

Right side is just a one-liner python expression.

Imports
==========

To make expressions really powerful, there is special section in a col file, where you can place your python imports,
or place small pieces of python code:

.. code-block:: col
    :caption: views.py

    from random import random

    %%

    [index: /]
    boo: random()


Model references
==================

To simplify referencing models, there is special syntax for referencing models:

.. code-block:: col
    :caption: views.py


    [index: /]
    boo: #cat.all()

    #cat
    ---------
    name

"#cat" will be replaced with "Cat.objects".

Sure you can reference models by full name still. This gives same result as above:

.. code-block:: col
    :caption: views.py

    from .models import Cat

    %%

    [index: /]
    boo: Cat.objects.all()

    #cat
    ---------
    name


Variable reuse
=================

Each next variable can use result of previous declarations:

.. code-block:: col
    :caption: views.py

    [index: /]
    boo: 123
    foo: 777 - boo


Url
======

There is special "url" object that gives access to url parameters

.. code-block:: col
    :caption: views.py

    [index: /myurl/<param1>/<param2>/<pk>]
    foo: "Params are: {}, {}.".format(url.param1, url.param2)
    cat: Cat.objects.get(pk=url.pk)

"url" also available in templates.

Request
=========

You can access Django request object:

.. code-block:: col
    :caption: views.py

    [index: /]
    me: request.user
