#import "@local/paperlet:0.0.0": paperlet
#show: paperlet.with(
  title: [
    Towards Improved Modelling of Something very Important using Deep Neural Networks
  ],
  authors: (
    (
      name: "Benj Fassbind",
      affiliation: "At Home, 4242 Earth",
      mail: "randombenj@gmail.com",
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
  image("kitten.jpg"),
  caption: [
    A sleeping kitten that should not be disturbed.

    #lorem(20)
  ],
)
#lorem(50)

= Related Work

#lorem(150) @lipsum

#bibliography("references.bib")
