exports.discoverMore = (req, res) ->
  setTimeout((() ->
    res.send({result: [
      {
        id: 34554
        name:'Albert Einstein'
        score: 99
      },
      {
        id: 23453
        name: 'Theory of Relativity'
        score: 70
      },
      {
        id: 476712
        name: 'Physics'
        score: 60
      },
      {
        id: 19472
        name: 'General Theory of Relativity'
        score: 50
      },
      {
        id: 45747
        name: 'Special Relativity'
        score: 40
      },
      {
        id: 100191
        name: 'Minkowski matrix'
        score: 30
      },
      {
        id: 194729
        name: 'Dark Matter'
        score: 5
      },
      {
        id: 13856
        name: 'Brownian Motion'
        score: 5
      }
    ]})
  ), 400)

exports.getBooks = (req, res) ->
  setTimeout((() ->
    res.send([{score: 9, name: 'The Special Theory of Relativity', author: 'Albert Einstein'}, {score: 9, name: 'The Special Theory of Relativity', author: 'Albert Einstein'}, {score: 9, name: 'The Special Theory of Relativity', author: 'Albert Einstein'}, {score: 9, name: 'The Special Theory of Relativity', author: 'Albert Einstein'}, {score: 9, name: 'The Special Theory of Relativity', author: 'Albert Einstein'}])
  ), 400)

webResult =
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

exports.getWebEntry = (req, res) ->
  retentry = {}
  for entry in webResult
    if entry.id + '' == req.query.id + ''
      retentry = entry
      console.log("asdf")

  setTimeout((() ->
    res.send(retentry)
  ), 400)

exports.getWeb = (req, res) ->
  setTimeout((() ->
    res.send(webResult)
  ), 400)

exports.getHome = (req, res) ->
  setTimeout((() ->
    res.render 'index', {}
  ), 400)

exports.getKeyword = (req, res) ->
  setTimeout((() ->
    res.send([{
                name: 'Physics'
                keyid: '12334SD45'
              },
              {
                name: 'Theory'
                keyid: '3J45JJRJ'
              },
              {
                name: 'Relativity'
                keyid: '23JJK45'
              },
              {
                name: 'Two body problem'
                keyid: '3495345'
              },
              {
                name: 'General Theory of Relativity'
                keyid: '346657'
              },
              {
                name: 'Minkowski matrix'
                keyid: '345345'
              },
              {
                name: "Dark Matter"
                keyid: '34534234'
              },
              {
                name: "Cosmology"
                keyid: '123689'
              },
              {
                name: "Germany"
                keyid: '245876'
              },
              {
                name: "Scientist"
                keyid: '2348456'
              },
              {
                name: "Nobel Prize"
                keyid: '23468'
              }
    ])
  ), 400)

exports.getContextId = (req, res) ->
  setTimeout((() ->
    res.send({ctxtid: 345678909})
  ), 400)

exports.getSuggestedQueries = (req, res) ->
  setTimeout((() ->
    res.send([{suggestedQuery: 'Albert Einstein Theory of Relativity'}, {suggestedQuery: 'Albert Einstein General Theory of Relativity'}, {suggestedQuery: 'Albert Einstein Nobel Prize'}])
  ), 400)

exports.initSearchContext = (req, res) ->
  setTimeout((() ->
    res.send({
      newSearchContext:
        searchContextId: '1330990ASD89ASD' + Math.floor(Math.random() * 100 + 1)
        stageId: '243SDF33'
        query: ''
        contextKeywords: []
    })
  ), 400)

exports.getTypeaheadSuggestion = (req, res) ->
  query = req.query.query
  query += "asdf"
  setTimeout((() ->
    res.send({
      suggestion:  query
    })
  ), 400)

exports.getSearchContextInfo = (req, res) ->
  setTimeout((() ->
    searchContextId = req.query.searchContextId
    if req.query.stageId?
      stageId = req.query.stageId
      res.send({
        currentSearchContext:
          searchContextId: searchContextId
          stageId: stageId
          contextKeywords: [
            'Albert Einstein',
            'Theory of Relativity'
          ]
          category: 'web'
          query: 'Albert Einstein work on Theory of Relativity'
      })
    else
      res.send({
        searchContextId: searchContextId
        stages: [
          {
            stageId: '234SAF'
          }
        ]
      })
  ), 400)

exports.addContextKeyword = (req, res) ->
  setTimeout((() ->
    res.send({
      persisted: true
    })
  ), 500)
