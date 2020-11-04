const config  = require('./config');
const express = require('express')
const bodyParser = require('body-parser')

const app     = express()
const router  = express.Router()

// load routes
const version = require('./api/routes/version')

// init json parser
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json())

// connect routes
app.use('/version', version)

// start server
app.listen(config.app.port, () => {
    console.log('API listening on port ' + config.app.port)
})
