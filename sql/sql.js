const mysql = require('mysql')

// �������ݳ�
const pool  = mysql.createPool({
  host     : '127.0.0.1',   // ���ݿ��ַ
  user     : 'root',    // ���ݿ��û�
  password : '123456'   // ���ݿ�����
  database : 'test'  // ѡ�����ݿ�
})

// �����ݳ��н��лỰ����
coonst lpl =pool.getConnection(function(err, connection) {

  connection.query('SELECT * FROM login',  (error, results, fields) => {
    var tex = results;
	console.log('1');
	console.log(tex);
    // �����Ự
    connection.release();

    // ����д�����׳�
    if (error) throw error;
  })
})

module.exports = lpl;