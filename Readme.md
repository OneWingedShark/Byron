# The Byron Project

The

Byron project is a community-driven Ada compiler, toolchain, and system all in one; its aims are:



1. To provide a freely available and freely usable implementation of the Ada 2012 programming language.

2. To provide a similarly free set of tools for the above.

3. To provide a common core for the community to build tools upon, and

4. To provide these services in a general form so that they might be extended as needed.



----


## Organization



Currently the only available componenets are a set of generic subprograms: a "transformation" which applies alterations to its input, "translation" which takes one type and returns another, and a "pass" which applies specified transformations to the input and output of a translation.