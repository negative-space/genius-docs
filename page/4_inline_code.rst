Inline code
################

You can include any arbitrary piece of python code into generated view:

.. code-block:: col
    :caption: views.py

    [index: /]
    boo: 321
    {
        # this code will be in resulting view
        print(123)
    }
