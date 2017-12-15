'use strict';

const Controller = require('egg').Controller;
const path = require("path")

class BaseController extends Controller {
  display({code = 200, res = {}, msg = 'success'}) {
    this.ctx.response.type = "application/json; charset=UTF-8"
    this.ctx.response.body = {
      code: code,
      res: res,
      msg: msg,
    };
    return;
  }

  getParam(param){
    const method = this.ctx.request.method;
    let params = {}
    if (method == 'GET') {
      params = this.ctx.request.query;
    } else if (method == 'POST') {
      params = this.ctx.request.body;
    }
    return params[param];
  }
  getAllParams(){
    const method = this.ctx.request.method;
    let params = {}
    if (method == 'GET') {
      params = this.ctx.request.query;
    } else if (method == 'POST') {
      params = this.ctx.request.body;
    }
    return params;
  }
}

module.exports = BaseController;
