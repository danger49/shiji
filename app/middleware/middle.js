/**
 * 接口层的中间件 处理登录判断等
 * @param options
 * @param app
 * @returns {test}
 */
module.exports = (options, app) => {
  return function* test(next) {
    console.log('middle test run!');
    console.log(options);
    yield next;
    return;
  };
};
