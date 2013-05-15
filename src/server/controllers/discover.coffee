exports.getKeywords = (req, res) ->
  res.send(
    {result: [
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
    ]}
  )