const Subscription = require('egg').Subscription;

class AddHistoryData10Second extends Subscription {
  /** 通过 schedule 属性来设置定时任务的执行间隔等配置
   *  type = worker 类型：每台机器上只有一个 worker 会执行这个定时任务，每次执行定时任务的 worker 的选择是随机的
   *  type = all 类型：每台机器上的每个 worker 都会执行这个定时任务
   */
  static get schedule() {
    return {
      interval: '10s', // 10秒间隔
      type: 'worker'
    };
  }

  // subscribe 是真正定时任务执行时被运行的函数
  async subscribe() {
    let res = await this.service.stock.insertHistoryTrade('100001', 1, 1.1, 1.4, 4.6, 0.8);
    // console.log('10秒执行的成交记录' + res);
  }
}

module.exports = AddHistoryData10Second;