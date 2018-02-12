const mysql = require('mysql')
const db = { 
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'test'
  }
//var connection = mysql.createConnection(db)

const Koa = require('koa');
const cors = require('koa-cors');
const Router = require('koa-router');
const app = new Koa();
const router = new Router();
app.use(cors());
const pool = mysql.createPool(db)
  
let query = function(sql, args) {
  
    return promise  = new Promise((resolve, reject) => {
        pool.getConnection(function(err, connection) {
            if (err) {
                resolve(err)
            } else {
                connection.query(sql, args, (err, result) => {
                    if (err) {
                        reject(err)
                        console.log(err)
                    } else {
                        resolve(result)
                    }
                    connection.release()
                })
            }
        })
    }).then(result => 
      {
        date=JSON.stringify(result)
        var x ='1'
        return (x)
        console.log(date)
      } )

}
async function selectAllData( ) {
  let sql = 'SELECT * FROM login'
  let dataList = await query( sql )
  return dataList
}

async function getData() {
  let dataList = await selectAllData()
  date=JSON.stringify(dataList)
  //console.log( date )
}

//getData()

router .get('/', ctx => { ctx.body = getData() }) 
.get('/user', ctx => { ctx.body = que2 }) 
app.use(router.routes()).use(router.allowedMethods());

// var que = chaxun('select * from login')
//   function chaxun(sql) {
//     connection.connect()
//     var data= connection.query(sql, function(error, results, fields) {
//       console.log('1')
//       //date=JSON.stringify(results);
//       console.log(date)
//       return ("date");
//       connection.end()     
//     })
//     return ("date2")
//    // })
//   }
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