define [
  'handlebars'
  'chaplin'
], (Handlebars, Chaplin) ->
  'use strict'

  mediator = Chaplin.mediator

  Handlebars.registerHelper('compare', (lvalue, rvalue, options) ->
    if (arguments.length < 3)
      throw new Error("Handlerbars Helper 'compare' needs 2 parameters")

    operator = options.hash.operator || "=="

    operators =
      '==':   (l,r) -> return l == r
      '!=':   (l,r) -> return l != r
      '<':    (l,r) -> return l < r
      '>':    (l,r) -> return l > r
      '<=':   (l,r) -> return l <= r
      '>=':   (l,r) -> return l >= r
      'typeof': (l,r) -> return typeof l == r

    if (not operators[operator])
      throw new Error("Handlerbars Helper 'compare' doesn't know the operator "+operator)

    result = operators[operator](lvalue,rvalue)

    if( result )
      return options.fn(this)
    else
      return options.inverse(this)
  )

  Handlebars.registerHelper('cal', (lvalue, rvalue, options) ->
    if (arguments.length < 3)
      throw new Error("Handlerbars Helper 'cal' needs 2 parameters")

    operator = options.hash.operator || "+"

    operators =
      '%':   (l,r) -> return l % r
      '+':   (l,r) -> return l + r
      '-':    (l,r) -> return l - r
      '/':    (l,r) -> return l / r
      '*':   (l,r) -> return l * r

    if (not operators[operator])
      throw new Error("Handlerbars Helper 'cal' doesn't know the operator "+operator)

    result = operators[operator](lvalue,rvalue)
    return options.fn(result)
  )