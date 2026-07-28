---
layout: archive
title: "Projects"
permalink: /projects/
author_profile: true
---

This page highlights engineering, research, and programming projects that demonstrate my experience in chemical engineering, biomaterials, scientific computing, and data analysis.

---

# Research Projects

This section includes research projects, engineering design, and interdisciplinary work.

{% assign other_projects = site.projects | where: "project_type", "other" | sort: "order" %}

{% for post in other_projects %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---

{% endfor %}
---

# MATLAB Projects

These projects demonstrate numerical methods, process calculations, engineering design, and data analysis developed using MATLAB.

{% assign matlab_projects = site.projects | where: "project_type", "matlab" | sort: "order" %}

{% for post in matlab_projects %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---

{% endfor %}


# Python Projects

These projects focus on scientific computing, data analysis, visualization, and engineering applications developed using Python.

{% assign python_projects = site.projects | where: "project_type", "python" | sort: "order" %}

{% for post in python_projects %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---

{% endfor %}
