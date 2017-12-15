'use strict';
const Service = require('egg').Service;
const crypto = require('crypto');
const request = require('request-promise');

class SmsService extends Service {
  getSmsSig(rand, curTime, phoneNumbers) {
    var phoneNumberStr = phoneNumbers[0];
    for (var i = 1; i < phoneNumbers.length; i++) {
      phoneNumberStr += (',' + phoneNumbers[i]);
    }

    // 一定要使用 utf-8 编码
    return crypto.createHash('sha256').update('appkey=' + this.app.config.sms.appkey + '&random=' + rand + '&time=' + curTime + '&mobile=' + phoneNumberStr, 'utf-8').digest('hex');
  }

  /**
   * 单发短信接口
   * @param {number} msgType 短信类型，0 普通短信，1 营销短信，请严格按照相应的类型填写
   * @param {string} nationCode 国家码，如果中国 86
   * @param {string} phoneNumber 手机号
   * @param {string} msg 短信正文，如果需要带签名，签名请使用【】标注
   * @param {string} extend 扩展字段，如无需要请填空字符串
   * @param {string} ext 此字段腾讯云后台服务器会按原样在应答中
   */
  async singleSmsSend(msgType, nationCode, phoneNumber, msg, extend, ext) {
    var rand = Math.round(Math.random() * 99999);
    var curTime = Math.floor(Date.now() / 1000);

    var reqObj = {
      tel: {
        nationcode: nationCode + '',
        mobile: phoneNumber + ''
      },
      type: Number(msgType),
      msg: msg,
      sig: this.getSmsSig(rand, curTime, [phoneNumber]),
      time: curTime,
      extend: extend,
      ext: ext
    };

    return request({
      url: this.app.config.sms.singleSmsUrl + '?sdkappid=' + this.app.config.sms.sdkappid + '&random=' + rand,
      method: 'POST',
      json: false,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(reqObj)
    }).then(res => {
      console.log(JSON.stringify(res));
      if (res.result === 0) {
        return true;
      } else {
        return false;
      }
    }).catch(err => {
      console.log(err)
      return false;
    });
  }

  /**
 * 带模板单发短信接口
 * @param {string} nationCode 国家码，如果中国 86
 * @param {string} phoneNumber 手机号
 * @param {number} templId 短信模板参数，如不清楚，请在 https://console.qcloud.com/sms/smsContent 查看
 * @param {array} params 模板参数数组，元素类型为 {string}，元素个数请不要超过模板参数个数
 * @param {string} sign 短信签名
 * @param {string} extend 扩展字段，如无需要请填空字符串
 * @param {string} ext 此字段腾讯云后台服务器会按原样在应答中
 */
async singleSmsSendWithParam(nationCode, phoneNumber, params, sign, extend, ext) {

    var rand = Math.round(Math.random()*99999);
    var curTime = Math.floor(Date.now()/1000);

    var reqObj = {
        tel: {
            nationcode: nationCode+'',
            mobile: phoneNumber+''
        },
        sign: sign,
        tpl_id: Number(this.app.config.sms.tplId),
        params: params,
        sig: this.getSmsSig(rand, curTime, [phoneNumber]),
        time: curTime,
        extend: extend,
        ext: ext
    };

    return request({
        url: this.app.config.sms.singleSmsUrl + '?sdkappid=' + this.app.config.sms.sdkappid + '&random=' + rand,
        method: 'POST',
        json: false,
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(reqObj)
    }).then(res => {
      console.log('腾讯云短信返回:', res);
      const rs = JSON.parse(res);
      if (rs.result == 0) {
        return true;
      } else {
        return false;
      }
    }).catch(err => {
      console.log(err)
      return false;
    });
  }
}

module.exports = SmsService
