'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  const middle = app.middlewares.middle({ test: 222 });
  router.get('/', middle, controller.home.index);
  router.get('/article', middle, controller.article.index);
  router.get('/article/:id', middle, controller.article.detail);

  // app.io.of('/')
  app.io.route('stock', app.io.controllers.stock.index);

  // app.io.of('/chat')
  // app.io.of('/').route('stock', app.io.controllers.stock.index);
};
