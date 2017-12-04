'use strict';
const Service = require('egg').Service;

class ArticleService extends Service {
  async list() {
    const articles = this.app.knex.select().where({}).from('t_news');
    return articles;
  }
  async detail(id) {
    const article = this.app.knex.first('*').where('id',id).from('t_news');
    return article;
  }
}

module.exports = ArticleService