const mysql = require('mysql')
const db = { 
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'test'
  }
var connection = mysql.createConnection(db)
const Koa = require('koa');
const cors = require('koa-cors');
const Router = require('koa-router');
const app = new Koa();
const router = new Router();


// router .get('/', ctx => { ctx.body = 'Home Page' }) 
// .get('/user', ctx => { ctx.body = 'User Page' }) 
// app.use(router.routes()).use(router.allowedMethods());

app.use(cors());
app.use( ctx => {
    ctx.body = 'hello world!';
})
chaxun('SELECT * FROM login')
  function chaxun(sql) {
    connection.connect()
    return new Promise((resolve, reject) => {
      connection.query(sql, function(error, results, fields) {
        console.log('1')
        console.log(results)
        if (error) {
          reject(error)
        } else {
          resolve(results)
        }
        connection.end()
        return results
      })
    })
  }
app.listen(3000);
console.log('koa2 is started at port 3000!');
// function getSyncTime() {
//     return new Promise((resolve, reject) => {
//       try {
//         let startTime = new Date().getTime()
//         setTimeout(() => {
//           let endTime = new Date().getTime()
//           let data = endTime - startTime
//           resolve( data )
//         }, 500)
//       } catch ( err ) {
//         reject( err )
//       }
//     })
//   }
  
//   async function getSyncData() {
//     let time = await getSyncTime()
//     let data = `endTime - startTime = ${time}`
//     return data
//   }
  
//   async function getData() {
//     let data = await getSyncData()
//     console.log( data )
//   }
  
//   getData()