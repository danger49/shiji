/**
 * 过滤中间件 功能待定
 * @param app
 * @returns {Function}
 */
module.exports = app => {
  return function* (next) {
    this.socket.emit('res', 'packet received!');
    console.log('packet:', this.packet);
    yield next;
  };
};
