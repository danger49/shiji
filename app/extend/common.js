const crypto = require('crypto');

/**
 * @param  {[type]} code [发型码]
 * @return {[type]} tableIdx [所在的表]
 */
exports.getTableIdx = (code) => {
	let md5 = crypto.createHash("md5");
	if (typeof code !== 'string'){
		code = code.toString();	
	}
	md5.update(code);  

	let str = md5.digest('hex'), 
	    strUpper = str.toUpperCase(),  //32位大写  
	    subStr = strUpper.substr(-1, 1);

	return parseInt(subStr, 16);
}

/**
 * [根据当前时间戳秒 除10000 得到的结果为轮次id]
 * @return {[type]} [description]
 */
exports.getRoundId = () => {
	let startTime = new Date().getTime() - new Date().getTime('2017-12-01 00:00:00'); 

	return 'A' + parseInt(startTime/10000);
}