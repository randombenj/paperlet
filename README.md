# Paperlet

An opinionated [typst](https://typst.app/) template for scientific papers.

The goal of this template was to ...

- ... create a clean and beautifully typed scientific paper.
- ... be readable on a mobile device.
- ... use all availabe space for figures and tables.
- ... have space for reviewers comments.


## Installation

To use this temaplate locally, clone this repository and
run:

```sh
make install
```

## Use Template

Start writing your scientific paper:

```typ
#import "@local/paperlet:0.0.0": paperlet
#show: paperlet.with(
  title: [
    Towards Improved Modelling of Something very Important using Deep Neural Networks
  ],
  authors: (
    (
      name: "It's You!",
      affiliation: "Some Affiliation, Address 42, Some Place",
      mail: "your-mail@mail.com",
    ),
  ),
  abstract: lorem(80),
  keywords: (
    "Typst", "Typography", "Scientific Paper", "Template", "Modern")
)

= Introduction

#lorem(90)

== Motivation

#lorem(100)

#figure(
  table(
    columns: 6,
    table.header[Technique][Advantage][Drawback][Comment][Decision][Includes Cats],
    [_Typst_], [Simple], [Fairly new], [Seems to work really well], [_YES_], [_YES_],
    [_LaTeX_], [Not so Simple], [Established ecosystem], [Seems to break all the time], [_YES_], [_YES_],
  ),
  caption: [#lorem(20)]
)

#lorem(40)

== Problem Statement
#lorem(50)

#figure(
  image("image.jpg"),
  caption: [
    A sleeping kitten that should not be disturbed.

    #lorem(20)
  ],
)
#lorem(50)

#bibliography("references.bib")
```

