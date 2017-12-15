/**
 * 身份验证中间件 用户socket频道处理
 * @param app
 * @returns {Function}
 */
module.exports = app => {
  return function* (next){
    this.socket.emit('res', 'connected!');
    
    //加入到所有频道
    app.io.of('/').adapter.allRooms((err, rooms) => {
      console.log('remoteJoin allrooms success',rooms);
    });
    yield next;
  };
};
