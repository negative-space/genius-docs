
@menu
###################

Example::

    @menu.main {
        index => "Home": page(index)
        dashboard => "Profile": page(dashboard)
    }

In template::

    <nav class="nav nav-navbar d-inline-flex">
        {% for ref, item in menu_main.items %}
        <a class="nav-link{% if item.active %} active{% endif %}" href="{{ item.link }}">{{ item.label }}</a>
        {% endfor %}
    </nav>
