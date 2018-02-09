//import db from '@/configs/db'
const mysql = require('mysql')
//module.exports = {
const db = { 
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'test'
}

var connection = mysql.createConnection(db)
// //查
// connection.query('SELECT * FROM login', function (error, results, fields) {
//   if (error) throw error;
//   console.log(results);
// });
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
  // json格式
  function writeJson(res, code = 200, msg = 'ok', data = null) {
    var obj = { code, msg, data }
    if (!data) {
      delete obj.data
    }
    res.send(obj)
  }

