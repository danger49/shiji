'use strict';

module.exports = appInfo => {
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_shiji';

  // add your config here
  config.middleware = ['token'];

  config.security = {
    csrf: false,
    methodnoallow: {
      enable: false
    },
    domainWhiteList: ['']
  };

  exports.cors = {
    origin: '*',
    allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH,OPTIONS',
    credentials: 'true'
  };

  config.io = {
    init: {}, // passed to engine.io
    namespace: {
      '/': {
        connectionMiddleware: ['auth'],
        packetMiddleware: ['filter'],
      },
    },
    redis: {
      host: '127.0.0.1',
      port: 6379,
      password: '',
      db: 0
    }
  };

  config.knex = {
    default: {
      dialect: 'mysql',
      connection: {
        database: null,
      },
      // connection pool
      pool: {min: 0, max: 5},
      // acquire connection timeout, millisecond
      acquireConnectionTimeout: 30000,
    },
    app: true,
    agent: false,
    // 单数据库
    client: {
      dialect: 'mysql',
      connection: {
        // host
        host: '',
        // port
        port: '3306',
        // username
        user: 'server',
        // password
        password: '',
        // database
        database: 'shiji_server',
        timezone: 'Asia/Shanghai',
      }
    }
  };

  config.redis = {
    client: {
      port: 6379,          // Redis port
      host: '127.0.0.1',   // Redis host
      password: '',
      db: 0,
    }
  };

  //手机短信第三方接口配置
  config.sms = {
    sdkappid: 0,
    appkey: '',
    singleSmsUrl: 'https://yun.tim.qq.com/v5/tlssmssvr/sendsms',
    multiSmsUrl: 'https://yun.tim.qq.com/v5/tlssmssvr/sendmultisms2',
    smsExpireTime: 120,
    tplId:63164,
  }

  //JWT TOKEN配置
  config.jwt = {
    key:"5555555555555",
    expiresIn: "7d",
    loginKeepTime: 604800,
  }

  return config;
};
