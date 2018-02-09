
var router = require('koa-router')();
var db = require("../../no-koa/app");

router.get('/', function *(next) {
  var rows = yield db.getById('tableName', {id:1});
  yield this.render('index', {
      title: rows[0].fieldName
  });
});

module.exports = router;