'use strict';

const BaseController = require('./base')

class ArticleController extends BaseController {
  async index() {
    const list = await this.service.article.list();
    this.display(list)
  }
  async detail() {
    const id = this.ctx.params.id || 0;
    const detail = await this.service.article.detail(this.ctx.params.id);
    this.display(detail)
  }
}

module.exports = ArticleController;
