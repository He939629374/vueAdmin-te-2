const Koa = require('koa');
const Router = require('koa-router');
const app = new Koa();

const router = new Router();
const a = '0';
const cors = require('koa2-cors');
const mysql = require('mysql')

const multer = require('koa-multer');//加载koa-multer模块 

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
function extend(target, source) {
        for (var obj in source) {
            target[obj] = source[obj];
        }
        return target;
    }
//获取列表
async function selectAllList(field) {
  let sql = 'SELECT * FROM list limit 0,' + field
  let sql2 = ' SELECT  COUNT(*) as len FROM list  '
  console.log(sql2)
  let dataList = await query( sql )
  let dataList2 = await query( sql2 )
  //var c = extend(JSON.parse(dataList), JSON.parse(dataList2));
  var d1=JSON.parse(dataList)
  var d2=JSON.parse(dataList2)
  var c = [d1,d2]
  console.log(c[1][0].len)
  //console.log('selectAllData:' + dataList )
  return (c)
}
async function searchList(field) {
	let sql = 'SELECT * FROM list where 1=1 '
	if(field.title){
		sql =sql +'and title = "' + field.title +  '" '
	}
	if(field.status){
		sql =sql + ' and status = "' +field.status +  '" '
	}
	if(field.pageviews){
		sql =sql + ' and pageviews = "' +field.pageviews +  '" '
	}
	sql =sql +  ' limit 0,' + field.limit

  //let sql = 'SELECT * FROM list where status = "'  + field.status + '" and pageviews = "' + field.pageviews + '" and title = "' + field.title + '" limit 0,' + field.limit 
  let sql2 = ' SELECT  COUNT(*) as len FROM list where status = "'  + field.status + '" and pageviews = "' + field.pageviews + '" and title = "' + field.title + '" '
  console.log(sql)
  let dataList = await query( sql )
  let dataList2 = await query( sql2 )
  console.log(dataList,dataList2)
  //var c = extend(JSON.parse(dataList), JSON.parse(dataList2));
  var d1=JSON.parse(dataList)
  var d2=JSON.parse(dataList2)
  var c = [d1,d2]
  //console.log(c[1][0].len)
  //console.log('selectAllData:' + dataList )
  return (c)
}
async function getList(que) {
  if(que.status||que.title||que.pageviews){
	   console.log('que.status')
	let dataList = await searchList(que)
	return (dataList)
  }else {
	let dataList = await selectAllList(que)  
	return (dataList)
  }
  //var a = JSON.parse(dataList)
  //console.log('result:'+dataList)
  
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
  console.log(ctx.query.password);
  console.log(ctx.querystring);
  ctx.body =await getData(ctx.query.name,ctx.query.password) 
  })
  .get('/list',async (ctx,next) => {
  console.log(ctx.query.limit);
  ctx.body =await getList(ctx.query.limit) 
  //console.log(ctx.body);
  })
  .get('/search',async (ctx,next) => {
  console.log(ctx.query);
  ctx.body =await getList(ctx.query) 
  //console.log(ctx.body);
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
// app.use(async (ctx, next) => {
    // // 允许来自所有域名请求
    // ctx.set("Access-Control-Allow-Origin", "*");
    // // 这样就能只允许 http://localhost:8080 这个域名的请求了
    // // ctx.set("Access-Control-Allow-Origin", "http://localhost:8080"); 

    // // 设置所允许的HTTP请求方法
    // ctx.set("Access-Control-Allow-Methods", "OPTIONS, GET, PUT, POST, DELETE");

    // // 字段是必需的。它也是一个逗号分隔的字符串，表明服务器支持的所有头信息字段.
    // ctx.set("Access-Control-Allow-Headers", "x-requested-with, accept, origin, content-type");

    // // 服务器收到请求以后，检查了Origin、Access-Control-Request-Method和Access-Control-Request-Headers字段以后，确认允许跨源请求，就可以做出回应。

    // // Content-Type表示具体请求中的媒体类型信息
    // ctx.set("Content-Type", "application/json;charset=utf-8");

    // // 该字段可选。它的值是一个布尔值，表示是否允许发送Cookie。默认情况下，Cookie不包括在CORS请求之中。
    // // 当设置成允许请求携带cookie时，需要保证"Access-Control-Allow-Origin"是服务器有的域名，而不能是"*";
    // ctx.set("Access-Control-Allow-Credentials", true);

    // // 该字段可选，用来指定本次预检请求的有效期，单位为秒。
    // // 当请求方法是PUT或DELETE等特殊方法或者Content-Type字段的类型是application/json时，服务器会提前发送一次请求进行验证
    // // 下面的的设置只本次验证的有效时间，即在该时间段内服务端可以不用进行验证
    // ctx.set("Access-Control-Max-Age", 300);

    // /*
    // CORS请求时，XMLHttpRequest对象的getResponseHeader()方法只能拿到6个基本字段：
        // Cache-Control、
        // Content-Language、
        // Content-Type、
        // Expires、
        // Last-Modified、
        // Pragma。
    // */
    // // 需要获取其他字段时，使用Access-Control-Expose-Headers，
    // // getResponseHeader('myData')可以返回我们所需的值
    // ctx.set("Access-Control-Expose-Headers", "myData");

    // await next();
// })
var storage = multer.diskStorage({  
  //文件保存路径  
  destination: function (req, file, cb) {  
    cb(null, 'public/uploads/')  
  },  
  //修改文件名称  
  filename: function (req, file, cb) {  
    var fileFormat = (file.originalname).split(".");  
    cb(null,Date.now() + "." + fileFormat[fileFormat.length - 1]); 
    let sql = "update msgform set imageUrl='public/uploads/" + file.originalname + "' where ID = 2"
    console.log('sql:' + sql )
    let dataList =  query( sql )
    //console.log('selectAllData:' + dataList )
    return dataList  	
  }

})  
//加载配置  
var upload = multer({ storage: storage });  
//路由  
router.post('/upload', upload.single('file'), async (ctx, next) => {  
  ctx.body = {  
    filename: ctx.req.file.filename//返回文件名  
  }  
})  
app.use(router.routes()).use(router.allowedMethods());
app.listen(3000);
console.log('3000!')
