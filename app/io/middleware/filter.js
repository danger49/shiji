/**
 * 过滤中间件 功能待定
 * @param app
 * @returns {Function}
 */
module.exports = app => {
  return function* (next){
    this.socket.emit('res', 'packet received!');
    //加入到指定频道 每只外汇为一个频道 需要客户端传入
    const packets = this.packet ? JSON.parse(this.packet[1]) : {};
    //如果有code字段就加入频道
    if (packets.code) {
      app.io.of('/').adapter.remoteJoin(this.socket.id, packets.code, (err) => {
        if (err) {
          this.socket.emit('res', {"code":"0","msg":"error code"});
          return;
        }
        console.log('remoteJoin '+packets.code+' success');
      });
    }
    yield next;
  };
};
