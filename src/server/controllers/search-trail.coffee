exports.forSearchContext = (req, res) ->
  res.send({
    trail: {
      1:
        query: 'Albert Einstein'
        keywords: ['Physics', 'Nobel Prize']
      2:
        query: 'Theory of Relativity'
        keywords: ['Special Theory of Relativity', 'General Theory of Relativity', 'Minkowski metrics']
      3:
        query: 'Albert Einstein and relativity'
        keywords: ['Special Theory of Relativity', 'General Theory of Relativity']
      4:
        query: 'Einsteins work other than relativity'
        keywords: ['Brownian motion', 'photoelectric effect']
      5:
        query: 'Einsteins work other than relativity'
        keywords: ['Quantum Physics', 'Bose-Einstein Statistics']
      6:
        query: 'Einsteins work other than relativity'
        keywords: ['Einstein-Cartan Theory', 'Wave particle duality']
    }
  })

exports.forUser = (req, res) ->
  res.send({msg: 'not implemented'})

exports.results = (req, res) ->
  res.send(trailResult)

trailResult =
  [{
    id: 2343454
    title: 'Special Theory of Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'en.wikipedia.org'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one <i class="highlight">inertial observer</i>, may occur non-simultaneously in the reference frame of another <i class="highlight">inertial observer</i>'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
    bookmarked: true
  },
  {
    id: 2344454
    title: 'Theory of Relativity - Wikipedia the free encyclopedia'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'en.wikipedia.org'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one <i class="highlight">inertial observer</i>, may occur non-simultaneously in the reference frame of another <i class="highlight">inertial observer</i>'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
    bookmarked: true
  },
  {
    id: 2341454
    title: 'Special Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'www.fearofphysics.com'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one inertial observer, may occur non-simultaneously in the reference frame of another inertial observer'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
    bookmarked: true
  },
  {
    id: 2349454
    title: 'Albert Einstein and Theory of Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'csep10.phys.utk.edu'
      name: 'Wikipedia'
    }
    snippets: [
      'Einstein discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one <i class="highlight">inertial observer</i>, may occur non-simultaneously in the reference frame of another <i class="highlight">inertial observer</i>'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  },
  {
    id: 2143412
    title: 'Special Theory of Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'en.wikipedia.org'
      name: 'Wikipedia'
    }
    snippets: [
      'Einstein discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one inertial observer, may occur non-simultaneously in the reference frame of another inertial observer'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  },
  {
    id: 2143450
    title: 'Einstein proposes his Theory of Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'www.bartlebay.com'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one <i class="highlight">inertial observer</i>, may occur non-simultaneously in the reference frame of another <i class="highlight">inertial observer</i>'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  },
  {
    id: 2143457
    title: 'Short words to explain Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'www.mupetlabs.com'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into <i class="highlight">Newtonian physics</i>',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one inertial observer, may occur non-simultaneously in the reference frame of another inertial observer'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  },
  {
    id: 2143458
    title: 'Theory of Relativity'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'www.allaboutscience.org'
      name: 'Wikipedia'
    }
    snippets: [
      'Einstein discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into Newtonian physics',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one <i class="highlight">inertial observer</i>, may occur non-simultaneously in the reference frame of another <i class="highlight">inertial observer</i>'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  },
  {
    id: 2143464
    title: 'Special and General Relativity Theory'
    url: 'http://en.wikipedia.org/wiki/Special_relativity'
    source: {
      link: 'www.thebigview.com'
      name: 'Wikipedia'
    }
    snippets: [
      '<i class="highlight">Einstein</i> discerned two fundamental propositions that seemed to be the most assured, regardless of the exact validity of the (then) known laws of either mechanics or electrodynamics',
      'The principle of relativity, which states that there is no preferred inertial reference frame, dates back to Galileo, and was incorporated into Newtonian physics',
      'Two events happening in two different locations that occur simultaneously in the reference frame of one inertial observer, may occur non-simultaneously in the reference frame of another inertial observer'
    ]
    score: {
      relevant: '14'
      'new': '128'
      'percent': '60'
    }
  }]
