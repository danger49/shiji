'use strict';

const Controller = require('egg').Controller;

class BaseController extends Controller {
  /**
   * 单点推送
   * @param client
   * @param cmd 推送命令
   * @param res 推送内容
   */
  single(cmd,res){
    this.ctx.socket.emit(cmd, res);
  }

  /**
   * 频道推送
   * @param room 频道号
   * @param cmd 推送命令
   * @param res 推送内容
   */
  room(room,cmd,res){
    this.ctx.socket.to(room).emit(cmd, res);
  }

  /**
   * 广播推送
   * @param cmd 推送命令
   * @param res 推送内容
   */
  broadcast(cmd,res){
    this.ctx.socket.broadcast.emit(cmd, res);
  }
}

module.exports = BaseController;
