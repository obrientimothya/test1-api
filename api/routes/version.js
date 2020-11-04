var express = require('express')
var router = express.Router()

router.get('/', function(req, res) {
    res.json({
        "myapplication": [
            {
                version: process.env.APP_VERSION,
                lastcommitsha: process.env.COMMIT_SHA,
                description: "pre-interview technical test"
            }
        ]
    })
})

module.exports = router
