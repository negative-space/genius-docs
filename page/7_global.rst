Global context
###############

There is special page "global" you can define. All data from this
page are stored in global context and will be available in all templates:

.. code-block:: col
    :caption: views.py

    [global]
    foo: 123

"global_context" function is generated, that you can add to settings to "context_processors" section.