'use strict';
const Service = require('egg').Service;
const jwt = require('jsonwebtoken');

const userRedisKey = {
  'USER_MOBILE_RANDOMSTR': 'shiji:user:mobile:randomstr:',
  'USER_TOKEN': 'shiji:user:token:'
}

class UserService extends Service {
  range(start, end) {
    var array = [];
    for (var i = start; i < end; ++i) {
      array.push(i);
    }
    return array;
  };

  async info(id) {
    const userInfo = this.app.knex.first('*').where('id', id).andWhere('delete_flag', 0).from('t_user');
    return userInfo;
  }

  async getInfoByMobile(mobile) {
    const userInfo = this.app.knex.first('id','name','mobile_no').where('mobile_no', mobile).andWhere('delete_flag', 0).from('t_user');
    return userInfo;
  }

  async insertUser(mobile) {
    const res = this.app.knex.insert({name: mobile, mobile_no: mobile}).into('t_user');
    return res;
  }

  //获取验证码
  async getSms(mobile) {
    //生成六位随机码
    const randomstr = this.range(0, 6).map((x) => {
      return Math.floor(Math.random() * 10);
    }).join('');
    const res = await this.setUserMobileRandomstr(mobile, randomstr, this.app.config.sms.smsExpireTime);
    return randomstr;
  }

  //验证码
  async check(mobile, sms) {
    const redisSms = await this.getUserMobileRandomstr(mobile);
    if (redisSms && redisSms == sms) {
      return true;
    }
    return false
  }

  //设置用户手机验证码过期时间
  async setUserMobileRandomstr(mobile, str, expireTime) {
    let key = userRedisKey.USER_MOBILE_RANDOMSTR + mobile;
    return this.app.redis.set(key, str, 'EX', expireTime);
  }

  //获取用户手机验证码
  async getUserMobileRandomstr(mobile) {
    let key = userRedisKey.USER_MOBILE_RANDOMSTR + mobile;
    return this.app.redis.get(key);
  }

  //删除用户手机验证码
  async delUserMobileRandomstr(mobile) {
    let key = userRedisKey.USER_MOBILE_RANDOMSTR + mobile;
    return this.app.redis.del(key);
  }

  //生成token
  createToken(str = {}) {
    //过期时间 7天 3600*24*7
    let time = this.app.config.jwt.expiresIn || 604800;
    let secret = this.app.config.jwt.key || '';
    str.timestamp = new Date().getTime();
    const token = jwt.sign({data: str}, secret, {expiresIn: time});
    return new Buffer(token).toString('base64')
  }

  //校验token
  checkToken(str) {
    try {
      let secret = this.app.config.jwt.key || '';
      const token = new Buffer(str, 'base64').toString()
      let decoded = jwt.verify(token, secret);
      if (decoded) {
        return decoded.data;
      }
      return false;
    } catch(err) {
      console.log('token校验失败',err);
      return false;
    }
  }

  //设置用户登录TOKEN
  async setUserToken(mobile, str) {
    let key = userRedisKey.USER_TOKEN + mobile;
    return this.app.redis.set(key, str, 'EX', this.app.config.jwt.loginKeepTime);
  }

  //获取用户登录TOKEN
  async getUserToken(mobile) {
    let key = userRedisKey.USER_TOKEN + mobile;
    return this.app.redis.get(key);
  }

  //删除用户登录TOKEN
  async delUserToken(mobile) {
    let key = userRedisKey.USER_TOKEN + mobile;
    return this.app.redis.del(key);
  }

  //判断用户是否登录 登录返回用户信息
  async checkLogin(mobile){
    //获取header
    const token = this.ctx.get('sj_token') || '';
    if (token) {
      //校验token
      const userInfo = this.checkToken(token)
      if (userInfo) {
        return userInfo;
      }
    } else {
      //缓存中获取
      const token = await this.getUserToken(mobile);
      if (token) {
        //校验token
        const userInfo = this.checkToken(token)
        if (userInfo) {
          //设置返回头
          this.ctx.set('sj_token',token);
          return userInfo;
        }
      }
    }
    return false;
  }
}

module.exports = UserService
