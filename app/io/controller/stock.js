'use strict';

const BaseController = require('./base');
const _ = require('lodash');

class StockController extends BaseController {
  /**
   * [index 首页搜索]
   * @return {[val]} [发行码、票名、全拼]
   */
  async index() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    if (_.isEmpty(params) || params.val == undefined) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'index', 'msg':'参数错误'});
      return;
    }

    let baseInfo = await this.service.stock.baseInfo(params.val);
    this.ctx.socket.emit('res', {'code':200, 'cmd':'index','result':baseInfo});
    /*this.single('res', baseInfo);
    if (params.val) {
      this.room(params.val, 'res', baseInfo);
    }
    this.broadcast('res', baseInfo);*/
  }

  //添加行情信息  
  async add() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    if (_.isEmpty(params) || params.code == undefined) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'add','msg':'参数错误'});
      return;
    }
    
    let info = await this.service.stock.getTicketInfo(params.code);
    if (_.isEmpty(info)) {
      this.ctx.socket.emit('res', {'code':2, 'cmd':'add', 'msg':'添加的'+params.code+'不存在'});
      return;
    }

    let userId=123456;
    let ticketInfo = await this.service.stock.getAddTicket(params.code, userId);
    if (!_.isEmpty(ticketInfo)) {
      this.ctx.socket.emit('res', {'code':3, 'cmd':'add', 'msg':params.code+'已添加'});
      return;
    }

    let result = await this.service.stock.add(params.code, userId);
    if (!_.isEmpty(result)) {
      let curInfo = await this.service.stock.newestInfo(params.code);
      this.ctx.socket.emit('res', {'code':200, 'cmd':'add', 'result':curInfo});
    } else {
      this.ctx.socket.emit('res', {'code':4, 'cmd':'add', 'msg':'添加失败'});
    }
  }
  
  //删除行情信息  
  async del() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    if (_.isEmpty(params) || params.code == undefined) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'del', 'msg':'参数错误'});
      return;
    }
    
    let userId=123456;
    let ticketInfo = await this.service.stock.getAddTicket(params.code, userId);
    if (_.isEmpty(ticketInfo)) {
      this.ctx.socket.emit('res', {'code':2, 'cmd':'del', 'msg':'你还未添加'+params.code});
      return;
    }

    let result = await this.service.stock.del(params.code, userId);
    let msg = result == 1 ? '删除成功' : '删除失败';
    this.ctx.socket.emit('res', {'code':200, 'cmd':'del', 'msg':msg});
  }

  //查询行情信息  
  async search() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    console.log('stock::search传入的参数', params);
    if (_.isEmpty(params) || params.code == undefined || params.type == undefined) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'search', 'msg':'参数错误'});
      return;
    }
    
    let list = await this.service.stock.search(params.code, params.type);
    let newestData = await this.service.stock.newestInfo(params.code);
    newestData = !_.isEmpty(newestData) ? newestData[0] : newestData;
    this.ctx.socket.emit('res', {'code':200, 'cmd':'search', 'list':list, 'newData':newestData});
  }

  //获取添加的列表列表信息  
  async ticketList() {
    let userId = 123456;
    let list = await this.service.stock.getTicketList(userId);
    let arr = [];
    for (let idx in list) {
      let pyname = list[idx]['pyname']+'SJ';
      let imgUrl = '';
      let startRate = list[idx]['start_rate'];
      let dvalue = list[idx]['cur_rate'] - startRate;
      let type = dvalue > 0 ? 1 : (dvalue == 0 ? 0 : -1);
      let chg = dvalue / startRate + '%';
      arr.push({'code':list[idx]['code'], 'name':list[idx]['name'], 'pyname':pyname, 'img':imgUrl, 'hotNum':startRate, 'type':type, 'chg':chg});
    }
    this.ctx.socket.emit('res', {'code':200, 'cmd':'ticketList', 'list':arr});
  }

  //支持
  async support() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    if (_.isEmpty(params) || params.code == undefined || params.count <= 0 || params.type != 1) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'support', 'msg':'参数错误'});
      return;
    }

    let userId = 123567;
    let res = await this.service.stock.supportOrOpposition(userId, 1, params.code, params.count);
    let result = !_.isEmpty(res) ? 1 : 0;
    this.ctx.socket.emit('res', {'code':200, 'cmd':'support', 'result':result});
  }

  //反对
  async opposition() {
    let params = this.ctx.args[0] ? JSON.parse(this.ctx.args[0]) : {};

    if (_.isEmpty(params) || params.code == undefined || params.count <= 0 || params.type != 0) {
      this.ctx.socket.emit('res', {'code':1, 'cmd':'opposition', 'msg':'参数错误'});
      return;
    }

    let userId = 123567;
    let res = await this.service.stock.supportOrOpposition(userId, 0, params.code, params.count);
    let result = !_.isEmpty(res) ? 1 : 0;
    this.ctx.socket.emit('res', {'code':200, 'cmd':'opposition', 'result':result});
  }

  /**
   * [getBaseTickList 获取原始的行情列表]
   * @return {[type]} [description]
   */
  async getBaseTickList() {
    let list = await this.service.stock.getBaseList();
    
    this.ctx.socket.emit('res', {'code':200, 'cmd':'ticketList', 'list':list});
  }

}

module.exports = StockController;