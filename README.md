# Paperlet

An opinionated [typst](https://typst.app/) template for scientific papers.

**[⬇ Download the example paper (PDF)](https://github.com/randombenj/paperlet/releases/download/latest/example.pdf)**,
built from [`example/example.typ`](example/example.typ) on every push to `main`.

The goal of this template was to ...

- ... create a clean and beautifully typed scientific paper.
- ... be readable on a mobile device.
- ... use all availabe space for figures and tables.
- ... have space for reviewers comments.

## Design

- **Serif titles, sans body.** Titles and section headings are set in
  [Newsreader](https://github.com/productiontype/Newsreader), an editorial
  serif with optical sizes. Body text is set in
  [Figtree](https://github.com/erikdkennedy/figtree), a friendly geometric
  sans in the spirit of Airbnb's Circular/Cereal. Code is set in
  [JetBrains Mono](https://www.jetbrains.com/lp/mono/). All three fonts use the
  OFL licence and are bundled in `font/`.
- **One column.** The text column is 135 mm wide (about 80 characters a line),
  set ragged-right at 9 pt with 1.45 line spacing.
- **A wide outer margin.** Use it for `#note[...]` margin notes and reviewer
  comments. The title extends into it, and section numbers hang in the left
  margin. Figures and tables sit on the text column; wrap the body in
  `#wide[...]` to let one extend into the margin as well.
- **Quiet tables.** Tables have no vertical rules. There is a firm rule under
  the header and at the end, faint hairlines between rows, and muted header
  labels. Numbers are right-aligned in tabular figures. Use
  `columns: (1fr, auto, ...)` to make a table fill the column, and a row
  `fill` to highlight a result.
- **Quiet details.** Captions are muted and kept at reading width. A single accent colour is used for links,
  citations and list markers.

## Installation

To use this temaplate locally, clone this repository and
run:

```sh
make install
```

## Use Template

Start writing your scientific paper:

```typ
#import "@local/paperlet:0.0.0": paperlet, note, wide
#show: paperlet.with(
  kicker: "Preprint",                 // small label above the title (optional)
  date: datetime.today(),             // optional
  title: [Towards Improved Modelling of Something Very Important],
  subtitle: [Using deep neural networks],  // optional
  short-title: [Improved Modelling],  // running header (defaults to title)
  authors: (
    (
      name: "It's You!",
      affiliation: "Some Affiliation, Address 42, Some Place", // or an array
      mail: "your-mail@mail.com",     // marks the corresponding author
    ),
  ),
  abstract: lorem(80),
  keywords: ("Typst", "Typography", "Scientific Paper"),
  accent: rgb("#c73e52"),             // links, citations, list markers
  justify: false,                     // ragged-right by default
)

= Introduction

#lorem(90)#note[A comment in the margin.]


