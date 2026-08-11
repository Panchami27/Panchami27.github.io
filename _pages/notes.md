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
Unit 1: Applications of heat transfer in engineering, modes of heat transfer, and heat transfer with and without phase change
Unit 2: Mechanism of conduction, Fourier's law, and development of equations for conduction heat transfer
Unit 3: Convection, hydrodynamic and thermal boundary layer thickness for flow over flat plate and in pipe, convective heat transfer coefficient, dimensionless numbers, forced convection, general methods for estimation of convection heat transfer coefficient
Unit 4: 

{% assign other_notes = site.notes | where: "note_type", "other" | sort: "order" %}

{% for post in other_notes %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---


{% endfor %}

---

# Computational Methods in Chemical Engineering

This section includes notes on:
Unit 1: Design Process [View Unit 1 Notes](/files/notes/CMCE-U1.pdf)
Unit 2: Reactor Design and Reactor Network Synthesis [View Unit 2 Notes](/files/notes/CMCE-U2.pdf)
Unit 3: Synthesis of Separation Trains [View Unit 3 Notes](/files/notes/CMCE-U3.pdf)
Unit 4: Synthesis of Heat Exchanger Networks [View Unit 4 Notes](/files/notes/CMCE-U4.pdf)
Unit 5: Energy Integrated Distillation Process [View Unit 5 Notes](/files/notes/CMCE-U5.pdf)
Unit 6: Design and Scheduling of Batch Processes [View Unit 6 Notes](/files/notes/CMCE-U6.pdf)
Lab manual including exercises by hand, excel, and MATLAB to solve problems from the above units [View CMCE Lab Manual Notes](/files/notes/CMCE-Lab-Manual.pdf)

{% assign other_notes = site.notes | where: "note_type", "other" | sort: "order" %}

{% for post in other_notes %}

## [{{ post.title }}]({{ post.url | relative_url }})

{{ post.excerpt }}

{% if post.header.teaser %}
<img src="{{ post.header.teaser | relative_url }}" width="250">
{% endif %}

---


{% endfor %}

{% endfor %}
