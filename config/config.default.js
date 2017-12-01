'use strict';

module.exports = appInfo => {
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_shiji';

  // add your config here
  config.middleware = [];

  config.io = {
    init: { }, // passed to engine.io
    namespace: {
      '/': {
        connectionMiddleware: ['auth'],
        packetMiddleware: ['filter'],
      },
      '/chat': {
        connectionMiddleware: [ 'auth' ],
        packetMiddleware: [],
      },
    },
    redis: {
      host: '127.0.0.1',
      port: 6379
    }
  };

  config.knex = {
    default: {
      dialect: 'mysql',
      connection: {
        database: null,
      },
      // connection pool
      pool: { min: 0, max: 5 },
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
        host: '127.0.0.1',
        // port
        port: '3306',
        // username
        user: 'root',
        // password
        password: 'password',
        // database
        database: 'time',
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

  return config;
};
