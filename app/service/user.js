'use strict';
const Service = require('egg').Service;

class UserService extends Service {
  async info(id) {
    const userInfo = this.app.knex.first('*').where('id',id).from('shiji_user_info');
    return userInfo;
  }
}
module.exports = UserService
