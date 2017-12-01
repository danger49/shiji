'use strict';

const Service = require('egg').Service;

class StockService extends Service {
  async baseInfo(id) {
    const baseInfo = this.app.knex.first('*').where('id',id).from('shiji_stock_base_info');
    return baseInfo;
  }
  async buy(){
    return 'success';
  }
  async sale(){
    return 'success';
  }
}
module.exports = StockService
