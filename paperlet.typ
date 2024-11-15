#let make-title(
  title,
  authors,
  abstract,
  keywords,
) = {
  set par(spacing: 1em)
  set text(font: "Open Sans")

  par(
    justify: false,
    text(20pt, title, weight: 400)
  )

  // Get unique affiliations
  let unique-affiliations = ()
  for author in authors [
    #if not unique-affiliations.contains(author.affiliation) [
      #unique-affiliations.push(author.affiliation)
    ]
  ]

  let unique-mails = ()
  for author in authors [
    #if "mail" in author.keys() and not unique-mails.contains(author.mail) [
      #unique-mails.push(author.mail)
    ]
  ]

  text(10pt,
    font: "STIX",
    authors.enumerate()
    .map(((i, author)) => [
      #box[
        #author.name#super[
          #(unique-affiliations.position(a => a == author.affiliation) + 1)#if "mail" in author.keys() [,\*]
        ]
      ]
    ])
    .join(", ")
  )
  parbreak()

  // Print unique affiliations with superscript indices
  for (i, affiliation) in unique-affiliations.enumerate() [
    #set text(9pt, font: "STIX")
    #super[#(i+1)]
    #affiliation \
    #v(-4pt)
  ]

  v(4pt)

  super[\*]
  text(
    9pt,
    font: "STIX",
    unique-mails.map((mail)  => link("mailto:" + mail))
    .join(", ")
  )

  v(8pt)
  set text(10pt)
  set par(justify: true)
  heading(outlined: false, bookmarked: false)[Abstract]
  text(font: "STIX", abstract)

  if keywords != () [
    #v(3pt)
    #set text(9pt, font: "STIX")
    Keywords:
    #if type(keywords) == str [
      #keywords
    ] else [
      #keywords.join(", ")
    ]
  ]
  line(length: 100%, stroke: (paint: gray, thickness: 0.1pt))
  v(18pt)
}

#let paperlet(
  title: none,
  authors: (),
  abstract: [],
  keywords: (),
  make-title: make-title,
  doc,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 3.0cm,
      bottom: 2.0cm,
      left: 2.8cm,
      right: 5.5cm,
      x: 1.6cm
    ),
  )
  set par(justify: true)
  set text(10pt, font: "STIX")
  set list(indent: 8pt)

  // show link: set text(underline: false)
  show heading: set text(size: 10pt, font: "Open Sans", weight: 600)
  show heading.where(level: 1): set text(size: 11pt)
  show heading.where(level: 1): set block(below: 10pt)

  place(
    make-title(title, authors, abstract, keywords),
    top,
    scope: "parent",
    float: true
  )

  show figure: it => align(left, block(width: 125%)[
    #it.body
    #block(width: 100% - 20%)[
      #it.caption
      #v(-2pt)
      #line(length: 100%, stroke: (paint: gray, thickness: 0.1pt))
    ]
  ])

  show table.cell.where(y: 0): strong
  set table(stroke: 0.1pt + gray)


  show bibliography: it => {
    set text(size: 8pt)
    it
}

  doc
}


