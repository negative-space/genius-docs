@crud
##############

@crud is a set of annotations that provide common operation on models
implementing the `CRUD <https://en.wikipedia.org/wiki/Create,_read,_update_and_delete>`_ model.

Crud annotation also generate html

Annotation types
===================

There is four annotations that may be applied to a pgae and @crud annotation that create
subpages for CRUD automatically.

@crud_create
--------------

Shows empty form to create new model instance. On form submit, validates, if all ok instance is created:

.. code-block:: col
    :caption: views.py

    [my_page: /]
    @crud_create(#cat)

    #cat
    --------
    name
    age: int

@crud_edit
--------------

Shows edit form for existing model instance.
On form submit, validates, if all ok instance is updated. Current model id is taken from
url.pk:

.. code-block:: col
    :caption: views.py

    [my_page: /<pk>]
    @crud_edit(#cat)

    #cat
    --------
    name
    age: int

@crud_delete
--------------

Shows confiramtion form asking to delete model instance.
On form submit instance is removed. Current model id is taken from
url.pk:

.. code-block:: col
    :caption: views.py

    [my_page: /<pk>]
    @crud_delete(#cat)

    #cat
    --------
    name
    age: int

@crud_detail
--------------

Shows details of model instance. Current model id is taken from url.pk:

.. code-block:: col
    :caption: views.py

    [my_page: /<pk>]
    @crud_detail(#cat)

    #cat
    --------
    name
    age: int

@crud
---------
Automatically creates four pages described above:


.. code-block:: col
    :caption: views.py

    [my_page: /mypage/]
    @crud(#cat)

    #cat
    --------
    name
    age: int


CRUD Customisation
=====================

All annotations have same set of parameters you can customise to change CRUD behaviour.
If you pass parameters to @crud, same set of parameters will be delegated to generated @crud_xxx
annotations for subsequent pages.


Skipping views
-------------------
You can omit some views if they are not needed:


.. code-block:: col
    :caption: views.py

    [my_page: /mypage/]
    @crud {
        #cat
        skip: delete, edit
    }

    #cat
    --------
    name
    age: int


Changing field list
---------------------

You can restrict set of fields available in forms. Syntax is same as in @admin:

.. code-block:: col
    :caption: views.py

    [my_page: /mypage/]
    @crud {
        #cat
        fields: *, ^age
    }

    #cat
    --------
    name
    age: int
    length: int
    weight: int

.. note::

    For non-generated models fields list should be just list of coma-separated field names, not
    `@admin`-like syntax.


Custom url parameter
----------------------

By default objects are located by url.pk, but you can change this behaviour:

.. code-block:: col
    :caption: views.py

    [my_page: /cats/<cat_id>]
    @crud {
        #cat
        pk_param: cat_id
    }

    #cat
    --------
    name
    age: int


Changing name of object in template
-------------------------------------

In edit and detail views object is available from template as "item", this can be changed:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    @crud {
        #cat
        item_name: cat
    }

    #cat
    --------
    name
    age: int


Rendering html into another block
-------------------------------------

By default, html is placed in "content" block, this can be changed:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    @crud {
        #cat
        block: my_block
    }

    #cat
    --------
    name
    age: int


Non-generated models
----------------------
You can easily use CRUD with external models as well, by specifying full model name.
But then you must to specify field list:


.. code-block:: col
    :caption: views.py

    [my_page: /mypage/]
    @crud {
        django.contrib.auth.User
        fields: first_name, last_name
    }


Object from context
---------------------

For edit/details/delete view custom object expression may be provided:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    @crud_edit {
        django.contrib.auth.User
        fields: first_name, last_name
        object_expr: request.user
    }

    #cat
    --------
    name
    age: int

Checking edit rights
-----------------------

You can restrict whisch users are able to create/edit/delete models:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    can_edit: request.user.id in (1, 2, 3)

    @crud {
        #cat
        edit_auth: can_edit
    }

    #cat
    --------
    name
    age: int


Initial arguments
-----------------------
You can assign some values to model, when creating new instance or editing. Also same syntax
affect list query, by filtering items:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    @crud {
        #cat<owner=request.user>
    }

    #cat
    --------
    name
    owner: one(django.contrib.auth.User)
    age: int


Url prefix
-----------------------
Url prefix can be added to subsequent pages:

.. code-block:: col
    :caption: urls.py

    [my_page: /cats]
    @crud {
        #cat
        url_prefix: this/is/custom/prefix/
    }

    #cat
    --------
    name
    age: int

Extra arguments to links
-------------------------
If page where you add @crud annotation, requires arguments, then you must specify it
explicitly, so generated links in html will be valid:

.. code-block:: col
    :caption: views.py

    [my_page: /cats/<category>]
    @crud {
        #cat
        link_extra: "category=url.category"
    }

    #cat
    --------
    name
    age: int

Success page
-----------------

By default, user will remain on same page after form submit, but this
can be changed:

.. code-block:: col
    :caption: views.py

    [my_page: /cats]
    @crud_create<<
        #cat
        => 'some_url', kwargs={'param1': self.object.pk}
    >>

    #cat
    --------
    name
    age: int

All arguments after => are passed directly to reverse_lazy() function.

.. note::
    Here are different braces used "<< >>", because {} are conflicting with kwargs.


Several CRUDs on one page
===========================

It is easy to use several @crud on one page by adding discriminator to annotation:


.. code-block:: col
    :caption: views.py

    [my_page: /cats/and/dogs]
    @crud.cats(#cat)
    @crud.dogs(#dog)

    #cat
    --------
    name
    age: int

    #dog
    --------
    name
    age: int

Crud will get url_prefix, pk_param and others will get prefix that is equal to descriminator.

Several levels of CRUDs
=============================

There is no problem to create several levels of cruds, but couple important things should be
done to make it working: link_extra, @merge and parent object in <>:

.. code-block:: col
    :caption: views.py

    [projects: $/dashboard/projects]
    @crud {
        #project<user=request.user>
        fields: *, ^user, ^created
        block: tab_content
    }


    [projects->projects_detail: $/dashboard/projects/<pk>/]
    item: Project.objects.get(user=request.user, pk=url.pk) @or_404
    @merge
    @crud.history {
        #history_item<user=request.user, project=Project.objects.get(pk=url.pk)>
        fields: source
        block: tab_content
        link_extra: "pk=url.pk"
    }


    #project
    ----------
    created: create_time
    user: one(cratis_profile.User)
    =name

    #history_item
    ----------
    ="{me.project} -> {me.created:%d.%m.%Y}: #{me.id}"

    created: create_time
    user: one(django.contrib.auth.User)
    project: one(#project -> history)
    source: longtext

Cruds may be nested as many levels as needed.