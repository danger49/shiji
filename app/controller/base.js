'use strict';

const Controller = require('egg').Controller;

class BaseController extends Controller {
  display(response){
    this.ctx.body = {
      code:'success',
      res:response
    };
  }
}

module.exports = BaseController;
