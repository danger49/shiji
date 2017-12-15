'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  const login = app.middlewares.login();
  router.get('/', controller.home.index);
  router.get('/article', controller.article.index);
  // 测试用  用完删除
  router.get('/article2', controller.article.index2);
  router.get('/article/detail/:id', controller.article.detail);
  router.get('/article/banner', controller.article.banner);
  router.get('/user/sms/:mobile', controller.user.getSms)
  router.post('/user/mobilelogin', controller.user.mobileLogin)
  router.get('/user/out/:mobile', controller.user.logout)

  app.io.of('/').route('stock', app.io.controller.stock.index);
  app.io.of('/').route('stock/add', app.io.controller.stock.add);
  app.io.of('/').route('stock/del', app.io.controller.stock.del);
  app.io.of('/').route('stock/search', app.io.controller.stock.search);
  app.io.of('/').route('stock/ticketList', app.io.controller.stock.ticketList);
  app.io.of('/').route('stock/getBaseTickList', app.io.controller.stock.getBaseTickList);
  app.io.of('/').route('stock/support', app.io.controller.stock.support);
  app.io.of('/').route('stock/opposition', app.io.controller.stock.opposition);
};
