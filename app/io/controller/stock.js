'use strict';

const BaseController = require('./base');

class StockController extends BaseController {
  async index() {
    const message = this.ctx.args[0];
    const baseInfo = await this.service.stock.baseInfo(1);
    this.ctx.socket.emit('res', baseInfo);
  }

  async buy() {
    const message = this.ctx.args[0];
    console.log('chat :', message + ' : ' + process.pid);
    const res = await this.service.stock.buy();
    this.ctx.socket.emit('res', res);
  }

  async sale() {
    const message = this.ctx.args[0];
    console.log('chat :', message + ' : ' + process.pid);
    const res = await this.service.stock.buy();
    this.ctx.socket.emit('res', res);
  }
}
module.exports = StockController;

