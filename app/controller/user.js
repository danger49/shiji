'use strict';

const BaseController = require('./base')
const _ = require('lodash');

class UserController extends BaseController {
  //获取验证码
  async getSms() {
    const mobile = this.ctx.params.mobile || 0;
    if (_.isEmpty(mobile)) {
      return this.display({
        code: this.app.constant.RESPONSE_CODE.ERROR_PARAM,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.ERROR_PARAM],
      })
    }
    const sms = await this.service.user.getSms(mobile);
    let smsparams = [sms,this.app.config.sms.smsExpireTime/60];
    const res = await this.service.sms.singleSmsSendWithParam('86', mobile, smsparams, '', '', '');
    if (res) {
      this.display({msg: this.app.constant.RESPONSE_MSG[201]})
    } else {
      this.display({
        code: this.app.constant.RESPONSE_CODE.GET_SMS_FAIL,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.GET_SMS_FAIL],
      })
    }
  }

  //验证码登陆
  async mobileLogin() {
    const mobile = this.getParam('mobile');
    const sms = this.getParam('sms');
    let userInfo = {};
    if (!mobile || !sms) {
      return this.display({
        code: this.app.constant.RESPONSE_CODE.ERROR_PARAM,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.ERROR_PARAM],
      })
    }
    const checkLoginRes = await this.service.user.checkLogin(mobile);
    if (checkLoginRes) {
      console.log('已经登录',checkLoginRes);
      return this.display({res:{userInfo: checkLoginRes}})
    }
    //验证手机和验证码
    const res = await this.service.user.check(mobile, sms);
    //验证不通过
    if (!res) {
      return this.display({
        code: this.app.constant.RESPONSE_CODE.ERROR_SMS,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.ERROR_SMS],
      })
    }
    //判断是否注册
    userInfo = await this.service.user.getInfoByMobile(mobile);
    if (!userInfo) {
      //未注册
      await this.service.user.insertUser(mobile);
      userInfo = await this.service.user.getInfoByMobile(mobile);
    }
    //登陆信息 生成token 加到header 返回用户信息
    const token = this.service.user.createToken(userInfo);
    this.ctx.set('sj_token',token);
    //设置缓存
    this.service.user.setUserToken(mobile, token);
    this.display({res:{userInfo: userInfo}})
  }

  async  logout(){
    const mobile = this.ctx.params.mobile;
    if (!mobile) {
      return this.display({
        code: this.app.constant.RESPONSE_CODE.ERROR_PARAM,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.ERROR_PARAM],
      })
    }
    const res = Promise.all([
      this.service.user.delUserToken(mobile),
      this.service.user.delUserMobileRandomstr(mobile),
    ]).then(res=>{
      if (res[0] === 0) {
        return false;
      } else {
        return true;
      }
    }).catch(err=>{
      console.log('退出失败',err);
      return false;
    });
    if (res) {
      this.display({msg: this.app.constant.RESPONSE_MSG[202]})
    } else {
      this.display({
        code: this.app.constant.RESPONSE_CODE.LOGOUT_FAIL,
        msg: this.app.constant.RESPONSE_MSG[this.app.constant.RESPONSE_CODE.LOGOUT_FAIL],
      })
    }
  }
}

module.exports = UserController;
