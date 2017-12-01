'use strict';

require('egg').startCluster({
  baseDir: __dirname,
  port: process.env.PORT || 7002, //default to 7001
  sticky: true,
}, (app) => {
  console.log('started',app);
});