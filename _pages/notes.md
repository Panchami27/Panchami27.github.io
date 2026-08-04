---
layout: archive
title: "Notes"
permalink: /notes/
author_profile: true
---

This page contains presentation notes on chemical engineering subjects including heat transfer, mass transfer, thermodynamics, chemical reaction engineering, fluid flow operations, process equipment design, computational methods for chemical engineering, and process intensification.

---

# Heat Transfer

This section includes notes on:
Unit 1: Applications of heat transfer in engineering, modes of heat transfer, and heat transfer with and without phase change.
Unit 2: Mechanism of conduction, Fourier's law, steady state heat conduction, development of equations for conduction heat transfer in plane wall, cylinder and sphere, compound resistances, critical thickness of insulation, multidimensional heat conduction.
Unit 3: Convection, thermal and velocity boundary layers, hydrodynamic and thermal boundary layer thickness for flow over flat plate and in pipe, convective heat transfer coefficient, dimensionless numbers in heat transfer and their significance, forced convection, general methods for estimation of convection heat transfer coefficient 
• Correlation equations for heat transfer in laminar and turbulent flow for external and 
internal flows

{% assign other_notes = site.notes | where: "note_type", "other" | sort: "order" %}

{% for post in other_notes %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---


{% endfor %}
