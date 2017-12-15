'use strict';

// had enabled by egg
// exports.static = true;
exports.io = {
  enable: true,
  package: 'egg-socket.io',
};
exports.knex = {
  enable: true,
  package: 'egg-knex',
};
exports.redis = {
  enable: true,
  package: 'egg-redis',
};
exports.cors = {
  enable: true,
  package: 'egg-cors',
};
