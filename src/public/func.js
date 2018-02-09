import axios from 'axios'
import db from '@/configs/db'
import mysql from 'mysql'
export default {
  chaxun(sql) {
    console.log('1')
    var connection = mysql.createConnection(db)
    connection.connect()
    console.log('11')
    return new Promise((resolve, reject) => {
      connection.query(sql, function(error, results, fields) {
        console.log('2')
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
  },
  abc(api) {
    console.log(api)
  },
  ajaxGet(api, cb) {
    axios.get(api)
      .then(cb)
      .catch(err => {
        console.log(err)
      })
  },
  ajaxPost(api, post, cb) {
    axios.post(api, post)
      .then(cb)
      .catch(err => {
        console.log(err)
      })
  },
  // json格式
  writeJson(res, code = 200, msg = 'ok', data = null) {
    var obj = { code, msg, data }
    if (!data) {
      delete obj.data
    }
    res.send(obj)
  }
}
