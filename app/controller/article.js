'use strict';

const BaseController = require('./base')

class ArticleController extends BaseController {
  async index() {
    const list = await this.service.article.list();
    this.display({res:list})
  }

  async index2() {
    const list = await this.service.article.list2();
    this.display({res:list})
  }
  
  async detail() {
    const id = this.ctx.params.id || 0;
    const detail = await this.service.article.detail(this.ctx.params.id);
    this.display({res:detail})
  }

  async banner() {
    const banner = await this.service.article.banner();
    this.display({res:banner})
  }
}

module.exports = ArticleController;
