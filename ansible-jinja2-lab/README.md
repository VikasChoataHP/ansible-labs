# Ansible Templating with Jinja2: A Complete Guide

## Overview

In this lab, we will explore Ansible templating using Jinja2, starting with the basics and progressing to advanced use cases. Below is the list of topics we will cover:

1. **Introduction to Ansible Templates**
2. **What is Jinja2?**
3. **Using Variables in Templates**
4. **Control Structures in Templates**
   - Loops
   - Conditionals
5. **Filters in Jinja2**
6. **Lookups and External Data**
7. **Using Template Module in Ansible**
8. **Customizing Output with Jinja2 Formatting**
9. **Advanced Jinja2 Concepts**
   - Macros
   - Template Inheritance
10. **Debugging Jinja2 Templates**

## 1. Introduction to Ansible Templates

Ansible templates allow you to dynamically generate configuration files or scripts using variables and logic. These templates are written in Jinja2, a powerful templating engine.

Templates are typically stored with a `.j2` extension and are rendered during playbook execution. They enable dynamic content generation, making your playbooks more flexible and reusable.

## 2. What is Jinja2?

Jinja2 is a Python-based templating engine widely used in Ansible for dynamic content generation. It provides:

- Variable interpolation
- Conditional statements
- Loops
- Filters to manipulate data

## 3. Using Variables in Templates

You can reference Ansible variables inside Jinja2 templates using `{{ variable_name }}`.

**Example Template (example.j2):**

```yaml
Hello, my name is {{ name }}.
I am from {{ location }}.
```

**Example Playbook:**

```yaml
- name: Render a simple template
  hosts: localhost
  vars:
    name: John
    location: Shimla
  tasks:
    - name: Create a file from template
      template:
        src: example.j2
        dest: /tmp/output.txt
```

## 4. Control Structures in Templates

### Loops

Use the `{% for %}` statement to loop over lists or dictionaries.

**Example Template:**

```yaml
Items in the list:
{% for item in items %}
- {{ item }}
{% endfor %}
```

### Conditionals

Use `{% if %}` statements to include conditional logic.

**Example Template:**

```yaml
{% if user == 'admin' %}
Welcome, Administrator!
{% else %}
Hello, {{ user }}.
{% endif %}
```

## 5. Filters in Jinja2

Filters allow you to transform data. Examples include `lower`, `upper`, `replace`, and `default`.

**Example Template:**

```yaml
Original: {{ value }}
Lowercase: {{ value | lower }}
Uppercase: {{ value | upper }}
```

## 6. Lookups and External Data

Lookups allow you to fetch data from external sources like files or environment variables.

**Example Template:**

```yaml
User's home directory is {{ lookup('env', 'HOME') }}.
```

## 7. Using Template Module in Ansible

The `template` module is used to process and deploy templates.

**Example Playbook:**

```yaml
- name: Deploy a configuration file
  hosts: localhost
  tasks:
    - name: Deploy template
      ansible.builtin.template:
        src: config.j2
        dest: /etc/myapp/config.conf
```

## 8. Customizing Output with Jinja2 Formatting

You can format the output using alignment, padding, and other text manipulations.

**Example Template:**

```yaml

| Name       | Age |
||--|
{% for user in users %}
| {{ user.name | ljust(10) }} | {{ user.age | center(3) }} |
{% endfor %}

```

## 9. Advanced Jinja2 Concepts

### Macros

Macros are reusable blocks of code.

**Example Template:**

```yaml
{% macro greet(name) %}
Hello, {{ name }}!
{% endmacro %}

{{ greet('John') }}

```

### Template Inheritance

Template inheritance allows you to create base templates and extend them.

**Base Template (base.j2):**

```yaml
<html>
<head><title>{{ title }}</title></head>
<body>
{% block content %}{% endblock %}
</body>
</html>

**Child Template:**

{% extends 'base.j2' %}
{% block content %}
<h1>Welcome to {{ title }}</h1>
{% endblock %}

```

## 10. Debugging Jinja2 Templates

### Common Debugging Techniques:

1. Use the `debug` module in Ansible to display variables.
2. Test templates using the `ansible.builtin.debug` task.
3. Use error handling filters like `default` to avoid issues with undefined variables.

**Example:**

Variable value: {{ variable | default('undefined') }}
