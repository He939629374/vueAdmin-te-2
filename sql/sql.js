const mysql = require('mysql')

// 创建数据池
const pool  = mysql.createPool({
  host     : '127.0.0.1',   // 数据库地址
  user     : 'root',    // 数据库用户
  password : '123456'   // 数据库密码
  database : 'test'  // 选中数据库
})

// 在数据池中进行会话操作
coonst lpl =pool.getConnection(function(err, connection) {

  connection.query('SELECT * FROM login',  (error, results, fields) => {
    var tex = results;
	console.log('1');
	console.log(tex);
    // 结束会话
    connection.release();

    // 如果有错误就抛出
    if (error) throw error;
  })
})

module.exports = lpl;