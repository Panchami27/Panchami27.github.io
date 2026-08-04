---
title: "Heat Exchanger Design Project 3"
collection: projects
permalink: /HCC/
project_type: matlab
date: 2026-07-28
order: 3

excerpt: "HCC.m code is written to design heat exchanger network using Hohmann/Lochart Composite Curve (HCC)."

header:
  teaser: /images/projects/heat-exchanger-design/HCC.png
---

## Overview

- HCC.m code is written to design heat exchanger newtork using Hohmann/Lochart Composite Curve (HCC).
- The output of the code gives the cold pinch point temperature, the hot composite curve, and the cold composite curve.
- Code needs to be refined further to shift the cold composite curve by deltaTmin to obtain the hot and cold utilities.
- Data used in code taken from Example 10.2 from Warren D. Seider, J. D. Seader, Daniel R. Lewin, Product and Process Design Principles: Synthesis, Analysis, and Evaluation, 2nd Edition, Wiley as a reference book.

<img src="{{ base_path }}/images/projects/heat-exchanger-design/example10-2.png" 
     alt="Example 10.2 Data" 
     style="width:80%; height:auto;">

### Skills

- MATLAB
- Heat Transfer
- Computational Methods

### Code

[Open MATLAB Code](https://github.com/Panchami27/Panchami27.github.io/blob/master/files/matlab/HCC.m){:target="_blank"}

Algorithm_2 is drawn to show the process to design heat exchanger network using Hohmann/Lochart Composite Curve (HCC).
<img src="{{ base_path }}/images/projects/heat-exchanger-design/algorithm2.png" 
     alt="Algorithm 2" 
     style="width:80%; height:auto;">
