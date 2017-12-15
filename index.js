'use strict';

require('egg').startCluster({
  baseDir: __dirname,
  port: process.env.PORT || 3000, //default to 3000
  sticky: true,
}, (app) => {
  console.log('started',app);
});