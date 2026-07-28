---
layout: archive
title: "Projects"
permalink: /projects/
author_profile: true
---

# Projects

This page contains a collection of engineering, computational, and research projects demonstrating my experience in chemical engineering, biomaterials, scientific computing, and data analysis. The projects include MATLAB programs, Python scripts, engineering calculations, and research tools developed during my academic and professional work.

---

{% assign sorted = site.projects | sort: "date" | reverse %}

{% for post in sorted %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---

{% endfor %}
