#import "@local/paperlet:0.0.0": paperlet, note, wide

#show: paperlet.with(
  kicker: "Example paper",
  date: datetime.today(),
  title: [Typesetting Science with Care],
  subtitle: [A short tour of the paperlet template],
  short-title: [Typesetting Science with Care],
  authors: (
    (
      name: "Benj Fassbind",
      affiliation: "Paperlet Project",
      mail: "randombenj@gmail.com",
    ),
  ),
  abstract: [
    Most scientific papers are typeset with defaults that were chosen decades ago for a different medium: two narrow columns, a dense serif and very little white space. This paper is both a description and a demonstration of _paperlet_, a Typst template that takes the opposite approach. It sets a single, comfortable column in a friendly sans-serif, uses an editorial serif for titles and headings, and keeps a wide outer margin for notes, reviewer comments and figures that need room. We summarise the typographic decisions behind the template, show every element it styles — headings, lists, equations, code, tables, figures, margin notes and references — and explain how to use them in your own work.
  ],
  keywords: ("Typst", "Typography", "Scientific writing", "Template"),
)

= Introduction

A paper is read far more often than it is written, yet its typography is usually an afterthought. Good typography does not draw attention to itself; it lowers the cost of reading so that the ideas can do the work @butterick2024. The decisions involved are old and well understood @bringhurst2004, and modern tools make them cheap to apply consistently.

This document is typeset with the template it describes. Everything you see — the title block above, the hanging section numbers, the quiet tables and the notes in the margin — is produced by a single `#show` rule.#note[This is a margin note. Use `#note[...]` for asides, reviewer comments or short definitions.]

== Design goals

The template was designed around four goals:

- *Readability first.* One column with a measure of roughly 80 characters, generous leading and ragged-right text.
- *Character without noise.* An editorial serif for titles and headings, a friendly geometric sans for the body, and a single accent colour.
- *Room to think.* A wide outer margin for notes and comments, and for figures that need more width than the text.
- *Good on any screen.* A layout that reads as well on a tablet as it does on paper.

= Typographic decisions

== Measure and leading

The length of a line, the _measure_, is the single biggest factor in how comfortable a text is to read @dyson2004. Lines that are too long make it hard to find the start of the next line; lines that are too short break up phrases. A common rule of thumb is 45 to 90 characters per line, including spaces @butterick2024. For a text column of width $w$ and a font whose average character is $c$ wide, the number of characters per line is approximately

$ n approx w / c. $ <eq-measure>

With a 135 mm column at 9 pt, @eq-measure gives roughly 80 to 90 characters per line, at the upper end of the comfortable range. Line spacing is set to about 145% of the font size, a little more than usual, because sans-serif faces with a large x-height need more air between lines.

== Typefaces

Titles and headings are set in Newsreader, a serif designed for editorial use whose letterforms adapt to the size they are set at. Body text is set in Figtree, a geometric sans with open shapes that remain legible at small sizes. Code is set in JetBrains Mono. All three are released under the SIL Open Font License and are bundled with the template.

#figure(
  table(
    columns: (1fr, auto, auto),
    table.header([Element], [Typeface], [Size]),
    [Title], [Newsreader], [26 pt],
    [Section heading], [Newsreader], [16 pt],
    [Subsection heading], [Newsreader], [12 pt],
    [Body text], [Figtree], [9 pt],
    [Captions, tables], [Figtree], [7.5–7.8 pt],
    [Code], [JetBrains Mono], [7.8 pt],
  ),
  caption: [The type scale used by the template. Sizes step down from the title in roughly a major-third ratio, so each level is clearly distinct without shouting.],
) <tab-scale>

The full scale is summarised in @tab-scale. Tables themselves follow the advice to remove everything that does not carry information @tufte2001: there are no vertical rules, a single firm rule separates the header from the data, and rows are divided by faint hairlines.

== Ragged right

Justified text looks tidy from a distance, but in a single column of sans-serif text it produces uneven word spacing unless hyphenation and line breaking are very good. Typst uses the Knuth–Plass algorithm @knuth1981, which helps, but ragged-right text remains the safer default. Set `justify: true` if you prefer justified paragraphs.

= Using the template

== Getting started

Install the template locally with `make install`, then add the following to the top of your document:

```typ
#import "@local/paperlet:0.0.0": paperlet, note, wide
#show: paperlet.with(
  title: [Your title],
  authors: ((name: "You", affiliation: "Your lab", mail: "you@lab.org"),),
  abstract: [What you did and what you found.],
)
```

== Figures and wide content

Figures and tables sit on the text column by default, and float to the top or bottom of a page so that they never leave half-empty pages behind. When a figure needs more room, wrap its body in `wide` and it will extend into the outer margin, as in @fig-kitten.

#figure(
  wide(image("kitten.jpg", width: 100%)),
  caption: [A sleeping kitten that should not be disturbed. Wide figures extend into the outer margin, while their captions stay at reading width.],
) <fig-kitten>

== Quotations

Block quotations are set in the serif italic with an accent rule, so they read as a distinct voice:

#quote(block: true)[Typography exists to honor content.]

The quotation above is the opening line of Bringhurst's book @bringhurst2004, and a good summary of the whole template.

= Conclusion

Typesetting a paper with care costs very little when the template does the work. We hope _paperlet_ makes your next paper a little more pleasant to read, and a little more pleasant to write.

#bibliography("references.bib", style: "apa")
