
@menu
###################

Menu is a simple way to organize navigation menus.

Pages links
====================

Using with pages is simplest scenario:

.. code-block:: col
    :caption: views.py

    [base]
    @menu.main<<
        index => "Home": page(index)
        dashboard => "Profile": page(dashboard)
    >>

    [base->index: /]

    [base->dashboard: /dashboard]

"main" is a menu name in template::

    <nav class="nav nav-navbar d-inline-flex">
        {% for ref, item in menu_main.items %}
        <a class="nav-link{% if item.active %} active{% endif %}" href="{{ item.link }}">{{ item.label }}</a>
        {% endfor %}
    </nav>


Reverse links
=================

Any reverse expression also may be used as menu link:


.. code-block:: col
    :caption: views.py

    [base]
    @menu.main<<
        index => "Home": page(index)
        dashboard => "Profile": page(dashboard)
        project => "Project": reverse('my_url', kwargs={'pk': 123})
    >>

    [base->index: /]

    [base->dashboard: /dashboard]

Plain url
=====================

.. code-block:: col
    :caption: views.py

    [base]
    @menu.main<<
        index => "Home": page(index)
        dashboard => "Profile": page(dashboard)
        project => "Project": url("https://google.com")
    >>

    [base->index: /]

    [base->dashboard: /dashboard]

Multiple menus on one page
=============================

You are free to use many menus per page, jsut give them different names::

    [base]
    @menu.main<<
        index => "Home": page(index)
        dashboard => "Profile": page(dashboard)
        project => "Project": reverse('my_url', kwargs={'pk': 123})
    >>

    @menu.other<<
        other_page => "Other": page(other)
        dashboard => "Profile": page(dashboard)
    >>

