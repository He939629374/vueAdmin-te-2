const Koa = require('koa');
const Router = require('koa-router');
const app = new Koa();
const router = new Router();
const a = '0';
const cors = require('koa2-cors');
const mysql = require('mysql')
const db = { 
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'test',
	timezone:"08:00"
  }
const bodyParser = require('koa-bodyparser');
app.use(bodyParser());
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
                        console.log('err'+err)
                    } else {
                        resolve(result)
                    }
                    connection.release()
                })
            }
        })
    }).then(result => 
      {
        date = JSON.stringify(result)
        return (date)       
      } )
}
async function selectAllData(que ) {
  let sql = 'SELECT password FROM login where user_name = ' +'"'+que+'"'
  let dataList = await query( sql )
  console.log('selectAllData:' + dataList )
  return dataList
}
async function getData(que,pas) {
  let dataList = await selectAllData(que)
  var a = JSON.parse(dataList)
  //console.log('getData():'+ a[0].password )
  if(pas == a[0].password){
	  return ('200')
  } else return  ('400')
}

//获取列表
async function selectAllList( ) {
  let sql = 'SELECT * FROM list'
  let dataList = await query( sql )
  //console.log('selectAllData:' + dataList )
  return dataList
}
async function getList() {
  let dataList = await selectAllList()
  //var a = JSON.parse(dataList)
  //console.log('result:'+dataList)
  return (dataList)
}

//新增列表
async function AddList(field) {
  let sql = 'INSERT INTO list ( author, display_time,title,pageviews,status ) VALUES '+" ( '" +
  field.author + "','"+ field.display_time + "','" +field.title + "','" + field.pageviews + "','" +field.status +"' )"
  console.log('sql:' + sql )
  let dataList = await query( sql )
  //console.log('selectAllData:' + dataList )
  return dataList
}
async function addList(que) {
  let dataList = await AddList(que)
  //var a = JSON.parse(dataList)
  console.log('result:'+dataList)
  return (dataList)
}

//删除列表
async function DelList(field) {
  let sql = "DELETE FROM list WHERE ID='" + field.id + "'" 
  console.log('sql:' + sql )
  let dataList = await query( sql )
  //console.log('selectAllData:' + dataList )
  return dataList
}
async function delList(que) {
  let dataList = await DelList(que)
  //var a = JSON.parse(dataList)
  console.log('result:'+dataList)
  return (dataList)
}

//更新列表
async function selectList(field) {
  let sql = 'update list set author=' +"'" + field.author + "'" +
  ',display_time=' +"'" + field.display_time + "'" +
  ',title=' + "'" + field.title + "'" +
  ',pageviews=' + "'" + field.pageviews + "'" +
  ',status=' +"'" + field.status + "'" +' where id=' +"'" + field.id +"'" 
  //console.log('sql:' + sql )
  let dataList = await query( sql )
  //console.log('selectAllData:' + dataList )
  return dataList
}
async function upList(que) {
  let dataList = await selectList(que)
  //var a = JSON.parse(dataList)
  //console.log('result:'+dataList)
  return (dataList)

}
router
  .get('/query',async (ctx,next) => {
  console.log(ctx.query.name);
  console.log(ctx.querystring);
  ctx.body =await getData(ctx.query.name,ctx.query.password) 
  })
  .get('/list',async (ctx,next) => {
  ctx.body =await getList() 
  })

router
  .post('/uplist',async (ctx,next) => {
  console.log(ctx.request.body)
  ctx.body = await upList(ctx.request.body)
})
  .post('/addlist',async (ctx,next) => {
  console.log(ctx.request.body)
  ctx.body = await addList(ctx.request.body)
})
  .post('/delList',async (ctx,next) => {
  console.log(ctx.request.body)
  ctx.body = await delList(ctx.request.body)
})

app.use(router.routes()).use(router.allowedMethods());

app.listen(3000);
console.log('3000!')
