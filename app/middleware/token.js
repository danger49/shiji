/**
 * 接口层的中间件 处理登录判断等
 * @param options
 * @returns {test}
 */
module.exports = () => {
  return async function token(ctx, next) {
    //获取token
    const token = ctx.request.get('sj_token') || '';
    if (token) {
      //校验token
      const userInfo = ctx.service.user.checkToken(token);
      if (!userInfo) {
        ctx.body = {
          code: ctx.app.constant.RESPONSE_CODE.ERROR_TOKEN,
          msg: ctx.app.constant.RESPONSE_MSG[ctx.app.constant.RESPONSE_CODE.ERROR_TOKEN],
        }
        return;
      }
      const oldToken = await ctx.service.user.getUserToken(userInfo.mobile_no);
      if (token != oldToken) {
        ctx.body = {
          code: ctx.app.constant.RESPONSE_CODE.EXPIRE_TOKEN,
          msg: ctx.app.constant.RESPONSE_MSG[ctx.app.constant.RESPONSE_CODE.EXPIRE_TOKEN]
        }
        return;
      }
      //刷新重置token
      const newtoken = ctx.service.user.createToken(userInfo);
      ctx.set('sj_token', newtoken);
      //设置缓存
      ctx.service.user.setUserToken(userInfo.mobile_no, newtoken);
    }
    await next();
    return;
  };
};
