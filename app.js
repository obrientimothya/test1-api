const config  = require('./config');
const express = require('express')
const app     = express()

//app.get('/', (req, res) => {
//    res.send('Hello, world!')
//})

app.listen(config.app.port, () => {
    console.log('API listening on port ' + config.app.port)
})
