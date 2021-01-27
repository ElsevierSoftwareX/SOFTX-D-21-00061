.. _listOfDescriptors:

===================
List of Descriptors
===================
For two-phase morphology, |graspi| computes the following set of descriptors:

* ``STAT_n`` - number of vertices
* ``STAT_e`` - number of interface edges
* ``STAT_n_D`` - number of black vertices
* ``STAT_n_A`` - number of white vertices
* ``STAT_CC_D`` - number of black connected components
* ``STAT_CC_A`` - number of white connected components
* ``STAT_CC_D_An`` - number of black connected components connected to top
* ``STAT_CC_A_Ca`` - number of white connected components connected to bottom
* ``ABS_wf_D`` - weighted fraction of black vertices
* ``ABS_f_D`` - fraction of black vertices
* ``DISS_f10_D`` - fraction of black vertices in 10 distance to interface
* ``CT_f_e_conn`` - fraction of interface with complementary paths to bottom and top
* ``CT_f_conn_D_An`` - fraction of black vertices connected to top
* ``CT_f_conn_A_Ca`` - fraction of white vertices connected to bottom
* ``CT_e_conn`` - number of interface edges with complementary paths
* ``CT_e_D_An`` - number of black interface vertices with path to top
* ``CT_e_A_Ca`` - number of white interface vertices with path to bottom
* ``CT_f_D_tort1`` - fraction of black vertices with straight rising paths (t=1)
* ``CT_f_A_tort1`` - fraction of white vertices with straight rising paths (t=1)

The name of each descriptor starts with the abbreviation of the step in the
photovoltaic process: light absorption (ABS), exciton dissociation (DISS),
and charge transport (CT). We additionally compute few statistical descriptors (STATS).

Below we provide the definitions of all above descriptors. We refer to
graph-centric terms defined in :ref:`basic definitions (BD) <basicDefinitions>` section.

``STAT_n``
==========
``STAT_n`` is number of vertices in the morphology. It is the total number of vertices in the graph.
It simply the cardinality of set :math:`V` (from :ref:`BD <basicDefinitions>`).


``STAT_e``
==========
``STAT_e`` is the number of interface edges. It is the interfacial area,
this is the total number of edges in the graph
connecting BLACK and WHITE vertices. Three steps are involved:

1. Input: Given labeled, weighted, undirected graph :math:`G=(V,E,W,L)``.
2. Construct set of edges, :math:`I=\{e=(u,v)\in E\;|\; (w(e)=1)\;\land\; ( L(u)=BLACK \land L(v)=WHITE\}`.
3. Output: :math:`|I|` -- the cardinality of interface edges.


``STAT_n_D``
============

``STAT_n_D`` - number of black vertices

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Identify set :math:`B` of all (electron donor) black vertices.
3. Output: :math:`|B|``, where :math:`|.|`` is the cardinality of the set.


``STAT_n_A``
============
``STAT_n_A`` - number of white vertices

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Identify set :math:`W` of all (electron donor) black vertices.
3. Output: :math:`|W|`, where :math:`|.|`` is the cardinality of the set.


``STAT_CC_D``
=============
``STAT_CC_D`` - number of black connected components

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all BLACK vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_B`, in :math:`G'`.
4. Output: :math:`|C_B|`.




``STAT_CC_A``
=============
``STAT_CC_A`` - number of white connected components

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all WHITE vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_W`, in :math:`G'`.
4. Output: :math:`|C_W|`.



``STAT_CC_D_An``
================
``STAT_CC_D_An`` - number of black connected components connected to top

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all BLACK and RED vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_B`, in :math:`G'`.
4. Output: :math:`|C_B|`.



``STAT_CC_A_Ca``
================
``STAT_CC_A_Ca`` - number of white connected components connected to bottom

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all WHITE and BLUE vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_W`, in :math:`G'`.
4. Output: :math:`|C_W|`.


``ABS_wf_D``
============
``ABS_wf_D`` - weighted fraction of black vertices


``ABS_f_D``
===========
``ABS_f_D`` - fraction of black vertices

*Background:* In a BHJ, light is usually absorbed by the electron-donor material.
A simple estimate of the fraction of electron-donor material provides some
insight into the amount of incident light absorbed. We include this trivial
estimate to demonstrate that different characterizations can be performed easily
using the graph approach.

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Identify set :math:`B` of all (electron donor) black vertices.
3. Output: :math:`|B|/|V|``, where :math:`|.|`` is the cardinality of the set.


``DISS_f10_D``
==============
``DISS_f10_D`` - fraction of black vertices in 10 distance to interface

*Background:* Light is absorbed to generate excitons. These excitons diffuse to the interface, only where they dissociate into charges. Excitons have a limited lifetime or a maximum distance called exciton diffusion length, after which they recombine. Therefore, we want to find the fraction of photoactive material whose distance to the interface is within this given range.
This descriptor is constructed in three steps. First, we construct the subgraph induced by a set of black and interface vertices. Next, using Dijkstra's algorithm the shortest paths between interface vertex and all other vertices in the induced subgraph are determined. The identification of all vertices whose path lengths are shorter than the given distance is the final stage of this procedure. Formally:

1. Input: Given labeled, weighted, undirected graph :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')``, where: :math:`V'`` is a
   set of all black and green vertices in :math:`V`, :math:`E'` is a set of all
   edges between vertices in :math:`V'``.
3. Find all shortest paths in :math:`G'` from interface vertex :math:`u' :math:`(L(u) = green)`.
4. Identify vertex set :math:`V_d=\{v \in V'\;|\;` (shortest_path(:math:`v`) :math:`<d`) :math:`\land (L(v) = black)\}`.
   Shortest_path (:math:`v`) denotes the distance between :math:`u` and :math:`v` in :math:`G'``.
5. Output: :math:`|V_d|/|B|``, where :math:`|B|`` is the cardinality of a set that consists of black vertices.

By varying the distance, :math:`d`, a histogram (or the probability mass function)
of the distances from donor to the interface can be computed.
This is particularly important for a broader analysis of BHJ morphology;
for example, when exciton diffusion length is not known a priori or if it
depends on operational conditions, e.g., temperature.



``CT_f_conn_D_An``
==================
``CT_f_conn_D_An`` - fraction of black vertices connected to top

*Background:* In an active layer (morphology) of OSC, charges can travel only
via one type of material. Holes travel to the anode via electron-donor material,
while electrons travel to cathode via electron-acceptor material. If there is no
direct connection the electrode (boundary) the charges will be trapped and eventually
recombine. To find the useful domain we compute the fraction of acceptor domains
(BLACK vertices) that have connection to top boundary (RED meta vertex) using
following steps:

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all BLACK and RED vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_B`, in :math:`G'`.
4. Identify component :math:`R` in :math:`C_B` that contains the RED meta vertex.
5. Let :math:`P` be the union of all BLACK vertices in :math:`R`.
6. Output: :math:`|P|/|B|`, where :math:`B` is the set of BLACK vertices.


``CT_f_conn_A_Ca``
==================
``CT_f_conn_A_Ca`` - fraction of white vertices connected to bottom

This descriptor is computed in the analogous was as ``CT_f_conn_D_An``. Note
different filtering criteria.

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced subgraph, :math:`G'=(V',E')`, where
   :math:`V'=\{v \in V\}` is a set of all WHITE and BLUE vertices in :math:`V`,
   :math:`E'`` is a set of all edges between vertices in :math:`V'`.
3. Compute the set of connected components, :math:`C_B`, in :math:`G'`.
4. Identify component :math:`R` in :math:`C_B` that contains the BLUE.
5. Let :math:`P` be the union of all WHITE vertices in :math:`R`.
6. Output: :math:`|P|/|W|`, where :math:`W` is the set of WHITE vertices.



``CT_f_e_conn``
===============
``CT_f_e_conn`` - fraction of interface with complementary paths to bottom and top

*Background:* In this descriptor, we focus on the fact that charge
transport is a complementary process (in OSC application). Specifically, even
if one type of charge has perfect pathways to reach the electrode, while its
complementary charge does not, the overall transport efficiency deteriorates,
due to space-charge effects and recombination.

We search for interface edges in the graph that connect black and white vertices,
where both vertices have paths to relevant electrodes (BLACK vertex has path to
anode and WHITE vertex has path to cathode). Formally,

* Let :math:`G_B` be the vertex-induced subgraph with black and anode vertices.
* Let :math:`G_W` be the vertex-induced subgraph with white and cathode vertices.
* Find a set :math:`I_c\subset I` of interface edges in the graph, such that the
  path from the BLCK vertex to RED exists in :math:`G_B` and the path from WHITE
  vertex to BLUE exists in :math:`G_W`.


This is computed using the following algorithm:

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct a filtered graph, :math:`G'=(V,E')``, where  :math:`E'`` is a set
   of edges connecting vertices of the same color.
3. Let :math:`I` be the set of all interface edges.
4. Identify connected components, :math:`C`, in :math:`G'`.
5. Compute subset :math:`R_r \subset C` of all components :math:`c\in C`,
   such that :math:`c` has BLACK vertices adjacent to RED in :math:`G` (from ``CT_f_conn_D_An``).
6. Compute subset :math:`R_b \subset C` of all components :math:`c\in C`, such
   that :math:`c` has WHITE vertices adjacent to BLUE in :math:`G` (from ``CT_f_conn_A_Ca``).
7. Identify subset, :math:`I_{rb} \subset I` where BLACK vertex belongs to
   set of vertices in :math:`R_r` and WHITE vertex belongs to set of vertices
   in :math:`R_b`.
8. Output: :math:`|I_{rb}|/|I|`.


This descriptor is formulated in a hierarchical way using ``CT_f_conn_D_An``
and ``CT_f_conn_A_Ca``. This hierarchical construction is one additional
advantage of our graph-based approach. Moreover, the next descriptor is
computed using intermediate data from this descriptor.

``CT_e_conn``
=============
``CT_e_conn`` - number of interface edges with complementary paths

This descriptor is computed as an intermediate step in the algorithm from
``CT_f_e_conn``. The number of interface edges is the cardinality of the set
:math:`|I_{rb}|`.

``CT_e_D_An``
=============
``CT_e_D_An`` - number of black interface vertices with path to top

This descriptor is computed as an analogous way as
``CT_f_e_conn``.

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct a filtered graph, :math:`G'=(V,E')``, where  :math:`E'`` is a set
   of edges connecting vertices of the same color.
3. Let :math:`I` be the set of all interface edges.
4. Identify connected components, :math:`C`, in :math:`G'`.
5. Compute subset :math:`R_r \subset C` of all components :math:`c\in C`,
   such that :math:`c` has BLACK vertices adjacent to RED in :math:`G` (from ``CT_f_conn_D_An``).
6. Compute subset :math:`R_b \subset C` of all components :math:`c\in C`, such
   that :math:`c` has WHITE vertices adjacent to BLUE in :math:`G` (from ``CT_f_conn_A_Ca``).
7. Identify subset, :math:`I_{r} \subset I` where BLACK vertex belongs to
   set of vertices in :math:`R_r`.
8. Output: :math:`|I_{r}|`.



``CT_e_A_Ca``
=============
``CT_e_A_Ca`` - number of white interface vertices with path to bottom

This descriptor is computed as an analogous way as
``CT_f_e_conn``.

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct a filtered graph, :math:`G'=(V,E')``, where  :math:`E'`` is a set
   of edges connecting vertices of the same color.
3. Let :math:`I` be the set of all interface edges.
4. Identify connected components, :math:`C`, in :math:`G'`.
5. Compute subset :math:`R_r \subset C` of all components :math:`c\in C`,
   such that :math:`c` has BLACK vertices adjacent to RED in :math:`G` (from ``CT_f_conn_D_An``).
6. Compute subset :math:`R_b \subset C` of all components :math:`c\in C`, such
   that :math:`c` has WHITE vertices adjacent to BLUE in :math:`G` (from ``CT_f_conn_A_Ca``).
7. Identify subset, :math:`I_{b} \subset I` where WHITE vertex belongs to set
   of vertices in :math:`R_b`.
8. Output: :math:`|I_{b}|`.



``CT_f_D_tort1``
================
``CT_f_D_tort1`` - fraction of black vertices with straight rising paths (t=1)

Straight rising paths are paths with tortuosity one (:math:`t`). Tortuosity is the ratio
between the path length to the relevant electrode through morphology, and ideal
straight path length to the electrode without any constraints.
Tortuosity is computed for domains that are connected to relevant electrode.
In case of this descriptor, the donor domains (BLACK vertices) connected to top
boundary (RED meta-vertex) are considered.

The graph-based algorithm to compute the fraction is given below:

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced graph, :math:`G'=(V',E')`, where :math:`V'=\{v \in V\}`
   is a set of all BLACK and RED vertices in :math:`V`, :math:`E'` is a set
   of all edges between vertices in :math:`V'`.
3. Let :math:`V_B\subset V'` be a set of BLACK vertices in :math:`V'` in :math:`G`.
4. Find the shortest paths from the RED to all BLACK vertices in :math:`G'` (filtered graph - step 2).
5. Find the shortest paths from the RED to all BLACK vertices in :math:`G` (original graph).
6. For each BLACK vertex compute the tortuosity using the shortest paths from step 5 and 4.
7. Filter the set :math:`V_{Bt1}` with all BLACK vertices that have the shortest path with :math:`t=1`.
8. Output: The fraction of BLACK vertices with straight rising paths :math:`|V_{Bt1}|/|V_B|`.



``CT_f_A_tort1``
================
``CT_f_A_tort1`` - fraction of white vertices with straight rising paths (t=1)

Similar to previous descriptor, the acceptor domains (WHITE vertices) connected to bottom
boundary (BLUE meta-vertex) are considered.

The graph-based algorithm to compute the fraction is given below:

1. Input: Given labeled, weighted, undirected graph, :math:`G=(V,E,W,L)`.
2. Construct vertex-induced graph, :math:`G'=(V',E')`, where :math:`V'=\{v \in V\}`
   is a set of all WHITE and BLUE vertices in :math:`V`, :math:`E'` is a set
   of all edges between vertices in :math:`V'`.
3. Let :math:`V_W\subset V'` be a set of WHITE vertices in :math:`V'` in :math:`G`.
4. Find the shortest paths from the BLUE to all WHITE vertices in :math:`G'` (filtered graph - step 2).
5. Find the shortest paths from the BLUE to all WHITE vertices in :math:`G` (original graph).
6. For each WHITE vertex compute the tortuosity using the shortest paths from step 5 and 4.
7. Filter the set :math:`V_{Wt1}` with all WHITE vertices that have the shortest path with :math:`t=1`.
8. Output: The fraction of WHITE vertices with straight rising paths :math:`|V_{Wt1}|/|V_W|` .
