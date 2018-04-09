Overview
####################

Pages allow to generate Views & and basic structure for templates.

Minimal page structure
========================

To create a page, just write a page name in square braces:

.. code-block:: col
    :caption: views.py

    [index]

Url
=======

Page may have an url::

    [index: /]

Or more complex url expression::

    [index: /cat/<pk>]

Url may be `"translatable" <https://docs.djangoproject.com/en/2.0/topics/i18n/translation/#django.conf.urls.i18n.i18n_patterns>`_, it means it will get language prefix like "/en/"::

    [index: $/cat/<pk>]

Template
===========

Every [page] has it's own template. By default template name will be "myapp/page_name.html".

But you can specify template name explicitly:

.. code-block:: col
    :caption: views.py

    [index: /: myindex_template.html]

Another cool trick is that you can generate template names dynamically:

.. code-block:: col
    :caption: views.py

    [index: /some/<username>: expr<"user_templates/{}.html" % url.username>]

Inside expr<...> you can insert any python code oneliner, but do not use ">", otherwise parser will not
be able to parse the expression.

.. note::
    If template does not exist, it will be generated as well.

Variables
============

Variables are just set of values that will available in template:

.. code-block:: col
    :caption: views.py

    [index: /]
    foo: "hello"
    boo: 123

foo & boo are variable names and any python expression on right side.

