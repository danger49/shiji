exports.RESPONSE_CODE = {
  'SUCCESS': 200,
  'ERROR': 100,
  'ERROR_PARAM': 101,
  'NO_LOGIN': 102,
  'ERROR_TOKEN': 103,
  'EXPIRE_TOKEN': 104,
  'GET_SMS_FAIL': 105,
  'ERROR_SMS': 106,
  'LOGOUT_FAIL': 107,
}

exports.RESPONSE_MSG = {
  '200': 'success',
  '201' : '短信已发送请注意查收',
  '202' : '退出成功',
  '100': '未知错误',
  '101': '参数错误',
  '102': '未登录',
  '103': '无效token',
  '104': 'token过期',
  '105': '获取短信验证码失败',
  '106': '验证码错误',
  '107': '退出失败',
}

exports.NEWS_TYPE = {
  'three_pic': 1,
  'two_pic': 2,
  'big_pic': 3,
  'small_pic': 4,
  'video': 5,
  'text': 6
}