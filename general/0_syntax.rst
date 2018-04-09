Overview
####################

Col file consists of four sections: page imports, pages, model imports, models::

    /* page imports */

    %%

    /* pages */

    %%

    /* model imports */

    %%

    /* models */


Pages imports are added to the begining of views.py, and model imports into the begining of
models.py.

Example::

    from something import something

    %%

    [index]
    [another]

    %%

    from something import something_another

    %%

    #cat
    ----------
    name

    #dog
    ----------
    name


Both import sections may be ommited::

    [index]
    [another]

    #cat
    ----------
    name

    #dog
    ----------
    name

If only model imports are needed, then you page import section should still be here,
even if it's empty::

    %%

    [index]
    [another]

    %%

    from something import something_another

    %%

    #cat
    ----------
    name

    #dog
    ----------
    name

If pages are also missing, then it looks like this::


    %%
    %%

    from something import something_another

    %%

    #cat
    ----------
    name

    #dog
    ----------
    name

Then parser clearly understands it is models import, not pages.
