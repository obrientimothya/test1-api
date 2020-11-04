const config = {
    app: {
        // listen tcp
        port: process.env.PORT || 3000,
        version: process.env.APP_VERSION || '',
        commit: process.env.COMMIT_SHA || ''
    }
}

module.exports = config;
