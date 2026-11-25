// paperlet — an opinionated, single-column template for scientific papers.
//
// Typography: serif display titles (Newsreader) over a friendly, highly
// readable geometric sans (Figtree), in the spirit of editorial design
// systems such as Airbnb's. One column with a ~70 character measure and a
// generous outer margin for notes, reviewer comments and wide figures.

// Typst registers the variable Newsreader under its default instance name.
#let serif = ("Newsreader 16pt",)
#let sans = ("Figtree",)
#let mono = ("JetBrains Mono",)

#let ink = rgb("#1d1d1f")
#let muted = rgb("#6e6e73")
#let hairline = rgb("#d2d2d7")

// A4 is 210mm wide: 22mm inner margin, 135mm text column, 53mm outer margin.
#let margin-left = 22mm
#let measure = 135mm
#let margin-right = 53mm
#let gutter = 6mm
// How far wide elements (title, figures, tables, header) reach into the margin.
#let outset = margin-right - 10mm
// Section numbers hang in the left margin.
#let hang = 14mm

#let _as-array(x) = if x == none { () } else if type(x) == array { x } else { (x,) }

#let _label(body, fill: muted) = text(
  font: sans,
  size: 7pt,
  weight: 600,
  tracking: 0.14em,
  fill: fill,
  upper(body),
)

/// Lets a figure body or table extend into the outer margin.
#let wide(body) = block(width: 100% + outset, body)

/// A note in the outer margin, aligned with the line it is called on.
#let note(body) = context {
  let x = here().position().x
  sym.wj
  box(width: 0pt, place(
    top + left,
    dx: margin-left + measure + gutter - x,
    dy: -0.7em,
    block(width: margin-right - gutter - 10mm, {
      set text(font: sans, size: 7pt, fill: muted)
      set par(justify: false, leading: 0.5em, first-line-indent: 0pt)
      body
    }),
  ))
}

/// Lays text out at the narrowest width that keeps its line count, so lines
/// come out evenly balanced (like CSS `text-wrap: balance`).
#let _balanced(body, width) = context {
  let height(w) = std.measure(block(width: w, body)).height
  let full = height(width)
  let w = width
  while w > width / 2 and height(w - 2mm) <= full { w -= 2mm }
  block(width: w, body)
}

#let make-title(
  title: none,
  subtitle: none,
  authors: (),
  abstract: none,
  keywords: (),
  kicker: none,
  date: none,
  accent: ink,
) = {
  let width = measure + outset
  let date = if type(date) == datetime { date.display("[month repr:long] [day], [year]") } else { date }
  let mails = ()
  for author in authors {
    if "mail" in author and author.mail not in mails { mails.push(author.mail) }
  }

  let kicker = (kicker, date).filter(x => x != none)
  if kicker != () {
    block(below: 1.8em, _label(kicker.join(h(0.5em) + sym.dot.c + h(0.5em)), fill: accent))
  }
  block(below: 14pt, _balanced(par(justify: false, leading: 0.45em, text(
    font: serif,
    size: 26pt,
    weight: 400,
    tracking: -0.015em,
    hyphenate: false,
    title,
  )), width))
  if subtitle != none {
    _balanced(par(justify: false, leading: 0.5em, text(
      font: serif,
      size: 14pt,
      style: "italic",
      fill: muted,
      hyphenate: false,
      subtitle,
    )), width)
  }

  if authors != () {
    let affiliations = ()
    for author in authors {
      for aff in _as-array(author.at("affiliation", default: none)) {
        if aff not in affiliations { affiliations.push(aff) }
      }
    }
    let marks(author) = {
      let idx = _as-array(author.at("affiliation", default: none)).map(a => str(affiliations.position(x => x == a) + 1))
      if affiliations.len() < 2 { idx = () }
      if "mail" in author { idx.push("*") }
      if idx != () { super(text(fill: accent, idx.join(","))) }
    }
    v(2.2em)
    block(below: 0.8em, text(
      size: 9pt,
      weight: 500,
      authors.map(a => box[#a.name#marks(a)]).join(", ", last: " and "),
    ))
    set text(size: 7.5pt, fill: muted)
    set par(leading: 0.5em, spacing: 0.5em, justify: false)
    if affiliations.len() > 1 {
      for (i, aff) in affiliations.enumerate() [
        #super(str(i + 1))#h(0.2em)#aff \
      ]
    } else if affiliations.len() == 1 [
      #affiliations.first() \
    ]
    if mails != () {
      block(width: width, [#super[\*]#h(0.2em)Correspondence: #mails.map(m => link("mailto:" + m, m)).join(", ")])
    }
  }

  if abstract != none {
    v(2.4em)
    block(below: 1em, _label[Abstract])
    par(justify: false, leading: 0.62em, text(font: serif, size: 10pt, abstract))
  }

  let keywords = _as-array(keywords)
  if keywords != () {
    v(1.4em)
    set text(size: 7.5pt)
    keywords
      .map(k => box(fill: luma(243), radius: 1em, inset: (x: 0.75em, y: 0.45em), k))
      .join(h(0.35em))
  }

  v(3.2em)
}

#let paperlet(
  title: none,
  subtitle: none,
  // Shown in the running header; defaults to the title.
  short-title: none,
  // Each author: (name: str, affiliation: str | array, mail: str).
  authors: (),
  abstract: none,
  keywords: (),
  // Small label above the title, e.g. "Preprint" or a journal name.
  kicker: none,
  date: none,
  accent: rgb("#c73e52"),
  justify: false,
  make-title: make-title,
  doc,
) = {
  set document(
    title: title,
    author: authors.map(a => a.name),
    keywords: _as-array(keywords).filter(k => type(k) == str),
  )

  set page(
    paper: "a4",
    margin: (left: margin-left, right: margin-right, top: 26mm, bottom: 26mm),
    header-ascent: 40%,
    header: context {
      let page = counter(page).get().first()
      if page > 1 {
        block(width: 100% + outset, text(font: sans, size: 7pt, fill: muted, {
          if short-title != none { short-title } else { title }
          h(1fr)
          text(number-width: "tabular", str(page))
        }))
      }
    },
  )

  set text(font: sans, size: 9pt, fill: ink, lang: "en", hyphenate: true)
  set par(
    justify: justify,
    leading: 0.78em,
    spacing: 1.3em,
    linebreaks: "optimized",
    first-line-indent: 0pt,
  )
  set strong(delta: 200)

  show link: set text(fill: accent)
  show ref: set text(fill: accent)
  show cite: set text(fill: accent)

  // Headings: serif for levels 1–2, sans for level 3+; numbers hang in the margin.
  set heading(numbering: (..n) => if n.pos().len() <= 2 { numbering("1.1", ..n) })
  let hanging(it) = if it.numbering != none {
    let num = counter(heading).display(it.numbering)
    if num != none {
      place(left, dx: -hang, box(width: hang - 0.7em, align(right, text(fill: muted, num))))
    }
  }
  show heading: set par(justify: false, leading: 0.4em)
  show heading: set text(hyphenate: false)
  show heading.where(level: 1): it => {
    set text(font: serif, size: 16pt, weight: 400, tracking: -0.01em)
    block(above: 2.6em, below: 1.1em, sticky: true, hanging(it) + it.body)
  }
  show heading.where(level: 2): it => {
    set text(font: serif, size: 12pt, weight: 400)
    block(above: 2.2em, below: 0.9em, sticky: true, hanging(it) + it.body)
  }
  show heading.where(level: 3): it => {
    set text(font: sans, size: 9pt, weight: 600)
    block(above: 1.9em, below: 0.85em, sticky: true, it.body)
  }
  show heading.where(level: 4): it => {
    set text(font: sans, size: 9pt, weight: 500, style: "italic")
    block(above: 1.6em, below: 0.8em, sticky: true, it.body)
  }

  // Lists.
  set list(indent: 0.1em, body-indent: 0.75em, spacing: 1em, marker: text(fill: accent)[•])
  set enum(indent: 0.1em, body-indent: 0.6em, spacing: 1em, numbering: n => text(fill: accent, weight: 600, str(n) + "."))
  set terms(separator: h(0.6em), hanging-indent: 1.2em)
  show terms: set par(first-line-indent: 0pt)

  // Math.
  set math.equation(numbering: "(1)")
  show math.equation.where(block: true): set block(above: 1.5em, below: 1.5em)

  // Code.
  show raw: set text(font: mono, size: 7.8pt)
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(247),
    inset: (x: 1.1em, y: 1em),
    radius: 3pt,
    above: 1.6em,
    below: 1.6em,
    it,
  )

  show quote.where(block: true): it => block(
    inset: (left: 1.2em, y: 0.2em),
    stroke: (left: 1.5pt + accent),
    above: 1.6em,
    below: 1.6em,
    text(font: serif, size: 10pt, style: "italic", it.body),
  )

  // Figures sit on the text column; wrap a body in `wide` to use the margin too.
  set figure(placement: auto)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => {
    set text(size: 7.5pt, fill: muted)
    set par(justify: false, leading: 0.55em)
    text(weight: 600, fill: ink)[#it.supplement #context it.counter.display(it.numbering)]
    h(0.6em)
    it.body
  }
  show figure: it => context {
    let caption = if it.caption != none { block(width: measure, align(left, it.caption)) }
    let top = figure.caption.position == top
    set align(left)
    let body = block(width: 100%, breakable: false, above: 2.4em, below: 2.4em, {
      if top { caption; v(1.1em) }
      align(left, it.body)
      if not top and caption != none { v(1.1em); caption }
    })
    // Replacing the figure's show rule drops its float behaviour, so restore it.
    if it.placement == none { body } else {
      place(it.placement, float: true, scope: it.scope, clearance: 2.4em, block(width: 100%, align(left, body)))
    }
  }

  // Tables: no vertical rules, a firm rule under the header and at the end,
  // faint hairlines between rows, right-aligned tabular figures.
  set table(
    stroke: (_, y) => (bottom: if y == 0 { 0.6pt + ink } else { 0.3pt + hairline }),
    inset: (x: 0.7em, y: 0.65em),
    align: (x, _) => if x == 0 { left + horizon } else { right + horizon },
  )
  show table: set text(size: 7.8pt, number-width: "tabular")
  show table: set par(justify: false, leading: 0.5em)
  show table.cell.where(y: 0): set text(weight: 500, fill: muted)
  // Drawn on top so the last row's hairline doesn't cover it.
  show table: it => box({
    it
    place(bottom + left, line(length: 100%, stroke: 0.6pt + ink))
  })

  // Footnotes.
  set footnote.entry(separator: line(length: 2.5cm, stroke: 0.5pt + hairline), gap: 0.5em, clearance: 1.4em)
  show footnote.entry: set text(size: 7.5pt, fill: muted)

  // Bibliography.
  set bibliography(title: [References])
  show bibliography: set text(size: 7.5pt)
  show bibliography: set par(justify: false, leading: 0.55em, spacing: 0.95em)

  make-title(
    title: title,
    subtitle: subtitle,
    authors: authors,
    abstract: abstract,
    keywords: keywords,
    kicker: kicker,
    date: date,
    accent: accent,
  )

  doc
}
