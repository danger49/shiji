'use strict';

const Service = require('egg').Service;
const _ = require('lodash');

class StockService extends Service {
  async baseInfo(val) {
    let info = this.app.knex('t_ticket_base').select('code','name','pyname')
                  .where('delete_flag', 0).andWhere('code', 'like', '%'+val+'%')
                  .orWhere('name', 'like', '%'+val+'%').orWhere('pyname', 'like', '%'+val+'%');
    return info;
  }

  /**
   * [getTicketInfo 根据code获取行情信息]
   * @param  {[type]} code [代码]
   * @return {[type]}      [返回结果]
   */
  async getTicketInfo(code) {
    let info = this.app.knex.first('*').where({code:code, delete_flag:0}).from('t_ticket_base');
    return info;
  }

  /**
   * [支持或反对]
   * @param  {[type]} userId [用户id]
   * @param  {[type]} type   [类型]
   * @param  {[type]} code   [发行码]
   * @param  {[type]} count  [购买的数量]
   * @return {[type]}        [返回结果]
   */
  async supportOrOpposition(userId, type, code, count){
    let idx = this.app.common.getTableIdx(code);
    let result = this.app.knex.insert({ticket_code:code, user_id:userId, type:type, count:count, add_time:this.app.knex.fn.now()})
    .into('t_trade_order_'+idx);
    return result;
  }

 /**
  * [查询行情信息]
  * @param  {[string]} code [交易码]
  * @param  {[int]} type [类型，1分、5分、等等]
  * @return {[array]}      [行情列表]
  */
  async search(code, type){
    let idx = this.app.common.getTableIdx(code);
    let condition = type == 0 ? {ticket_code:code, delete_flag:0} : {ticket_code:code, type:type, delete_flag:0};
    let list = this.app.knex('t_trade_history_'+idx).select().orderBy('add_time', 'asc').where(condition);
    return list;
  }
  
  /**
   * [当前发型码最新数据]
   * @param  {[type]} code [交易码]
   * @return {[type]}      [返回结果]
   */
  async newestInfo(code){
    let info = this.app.knex.select('ttb.pyname','ttb.name','tti.cur_rate','tti.max_rate','tti.min_rate','tti.start_rate','tti.end_rate')
    .from('t_ticket_info as tti').leftJoin('t_ticket_base as ttb', 'tti.ticket_code', 'ttb.code')
    .where({'tti.ticket_code':code, 'ttb.delete_flag':0,'tti.delete_flag':0});
    return info;
  }
  
  /**
   * [getTicketList 获取添加的列表]
   * @return {[type]} [返回结果]
   */
  async getTicketList(userId){
    let list = this.app.knex.select('ttb.code', 'ttb.pyname', 'ttb.name','tti.cur_rate','tti.max_rate','tti.min_rate','tti.start_rate','tti.end_rate')
    .from('t_ticket_add as tta').leftJoin('t_ticket_info as tti', 'tta.ticket_code', 'tti.ticket_code')
    .leftJoin('t_ticket_base as ttb', 'tta.ticket_code', 'ttb.code')
    .where({'tta.user_id':userId,'tta.delete_flag':0,'ttb.delete_flag':0,'tti.delete_flag':0});
    return list;
  }

   /**
   * [添加票据信息]
   * @param  {[type]} code [交易码]
   * @return {[type]}      [返回结果]
   */
  async add(code, userId){
    let res = this.app.knex.insert({ticket_code:code, user_id:userId, add_time:this.app.knex.fn.now()}).into('t_ticket_add');
    return res;
  }

   /**
   * [删除票据信息]
   * @param  {[type]} code [交易码]
   * @return {[type]}      [返回结果]
   */
  async del(code, userId){
    let res = this.app.knex('t_ticket_add').where({ticket_code:code, user_id:userId}).del();
    return res;
  }

  /**
   * [getBaseList 获取原始的行情列表]
   * @return {[type]} [返回结果]
   */
  async getBaseList(){
    let list = this.app.knex.select('ttb.code', 'ttb.pyname', 'ttb.name','tti.cur_rate','tti.max_rate','tti.min_rate','tti.start_rate','tti.end_rate')
    .from('t_ticket_info as tti').leftJoin('t_ticket_base as ttb', 'tti.ticket_code', 'ttb.code')
    .where({'ttb.delete_flag':0,'tti.delete_flag':0});
    return list;
  }

  /**
   * [获取添加的票据信息]
   * @param  {[type]} code [交易码]
   * @return {[type]}      [返回结果]
   */
  async getAddTicket(code, userId) {
    let info = this.app.knex.first('*').where({ticket_code:code, user_id:userId, delete_flag:0}).from('t_ticket_add');
    return info;
  }

  /**
   * [insertHistoryTrade 交易历史信息表]
   * @param  {[type]} code      [代码]
   * @param  {[type]} type      [类型]
   * @param  {[type]} startRate [开始汇率]
   * @param  {[type]} curRate   [当前汇率]
   * @param  {[type]} maxRate   [最大汇率]
   * @param  {[type]} minRate   [最小汇率]
   * @return {[type]}           [返回结果]
   */
  async insertHistoryTrade(code, type, startRate, curRate, maxRate, minRate) {
    return 'test success';
    
    let idx = this.app.common.getTableIdx(code);
    let res = this.app.knex.insert({ticket_code:code, start_rate:startRate, cur_rate:curRate, 
        max_rate:maxRate, min_rate:minRate, add_time:this.app.knex.fn.now()})
        .into('t_trade_history_'+idx);
    return res;
  }

}

module.exports = StockService;