Inheritance
################

Basics
=========

Pages can extend each other:

.. code-block:: col
    :caption: views.py

    [base]
    foo: 123

    [base->index: /]
    boo: 321

If one page extends another, it means all variables from parent page will be accessible in
child page.

.. note::

    Generated templates will also extend each other, repeating view hierarchy.

Multiple inheritance
=======================

There is no restriction on inheritance deepness:

.. code-block:: col
    :caption: views.py

    [level0]

    [level0->level1]

    [level1->level2]

    [level2->level3]

    [level3->level4]

    [level4->level5]

    [level5->level6]

    [level6->level7]

Hide variable from children
=============================

Sometime it is useful to hide some variables from child page, but keep hierarchy:

.. code-block:: col
    :caption: views.py

    [projects: /projects/]
    _projects: Project.objects.all()
    foo: 123

    [projects->project: /projects/<pk>]
    project: Project.objects.get(pk=url.pk) @or_404

"projects" variable will be accessible only in "projects" view, but not in "project".
This allows not to execute "Project.objects.all()" query in children views.

Access data from parent
=========================

Parent'pages data is not available in local scope, but can be access through "data" object:

.. code-block:: col
    :caption: views.py

    [base]
    foo: 123

    [base->index: /]
    boo: 321 + data.foo
