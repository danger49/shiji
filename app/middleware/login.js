/**
 * 接口层的中间件 处理登录判断等
 * @param options
 * @returns {test}
 */
module.exports = () => {
  return async function login(ctx, next) {
    const token = ctx.request.get('sj_token') || '';
    if (!token) {
      ctx.body = {
        code: ctx.app.constant.RESPONSE_CODE.NO_LOGIN,
        msg: ctx.app.constant.RESPONSE_MSG[ctx.app.constant.RESPONSE_CODE.NO_LOGIN],
      }
      return;
    }
    const res = ctx.service.user.checkToken(token);
    if (!res) {
      ctx.body = {
        code: ctx.app.constant.RESPONSE_CODE.ERROR_TOKEN,
        msg: ctx.app.constant.RESPONSE_MSG[ctx.app.constant.RESPONSE_CODE.ERROR_TOKEN],
      }
      return;
    }
    await next();
    return;
  };
};
