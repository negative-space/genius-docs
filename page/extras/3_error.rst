
@error(xxx)
############################

You can easily override error pages with @error annotation:

.. code-block:: col
    :caption: views.py

    [not_found]
    boo: 321

    @error(404)


.. code-block:: col
    :caption: views.py

    [just_error]
    boo: 123

    @error(500)
