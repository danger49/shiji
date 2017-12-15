'use strict';

const BaseController = require('./base')

class HomeController extends BaseController {
  async index() {
    this.display({res:'welcome!'})
  }
}

module.exports = HomeController;
