process.env.NODE_ENV = 'test'

const chai     = require('chai')
const chaiHttp = require('chai-http')
const should   = chai.should()
const server   = require('../app')

chai.use(chaiHttp)

// TEST ROUTE GET:/version
describe('GET /version', () => {
    it('it should return valid JSON about my application', (done) =>{
        chai.request(server)
            .get('/version')
            .end((err, res) => {
                console.log(res.body)
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('myapplication')
                    .that.has.a('array');
                res.body.myapplication[0].version.should.equal(process.env.APP_VERSION);
                res.body.myapplication[0].lastcommitsha.should.equal(process.env.COMMIT_SHA);
                res.body.myapplication[0].description.should.equal('pre-interview technical test');
                done();
            })
    })
})
