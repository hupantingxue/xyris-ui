winston = require 'winston'

logger = new (winston.Logger)(
  transports: [
    new (winston.transports.Console)(),
    new (winston.transports.File)(filename: 'xyris.server.log')
  ]
)

module.exports = logger