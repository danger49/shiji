'use strict';
const Service = require('egg').Service;
const child_process = require("child_process");
const Promise = require('promise');
const https = require('https');

// 后续统一放置
const articleRedisKey = {
  // 标志位  用来判断是否需要重新拉取数据
  'ARTICLE_INDEX_FALG'   : 'shiji:article:index:flag',
  // 首页 详情页内容
  'ARTICLE_INDEX_DETAIL' : 'shiji:article:index:detail',
  // 标志位 明星新闻
  'ARTICLE_STAR_FLAG'    : 'shiji:article:star:flag:',
  // 明星新闻 详情页
  'ARTICLE_STAR_DETAIL'  : 'shiji:article:star:detail:'
}

class ArticleService extends Service {	
  async list() {
    console.log('请求获取首页新闻推荐');
    //let redisData = await this.app.redis.get(key);
    //const articles = this.app.knex.select().where({}).from('t_news');
	  //let curl = 'curl https://index.toutiao.com/api/news/reports/normal?page=1&size=4&position=index';
      /*let stdout = {
            "return_count": 8,
             "has_more": false, 
             "page_id": "/news_entertainment/", 
             "_ck": {}, 
             "html": null,
              "data": [{"media_name": "\u4e09\u4e03\u504f\u5206", "ban_comment": 0, "abstract": "\u8bf4\u5230\u5a31\u4e50\u5708\u4e2d\u98ce\u4eba\u6d41\u6709\u5f88\u591a\uff0c\u5f20\u94c1\u6797\u4e5f\u7b97\u5f97\u4e0a\u662f\u5176\u4e2d\u4e00\u4e2a\u5427\uff0c\u5f88\u591a\u4eba\u90fd\u77e5\u9053\uff0c\u5f20\u94c1\u6797\u7684\u4f5c\u54c1\u4e5f\u662f\u5f88\u591a\u7684\uff0c\u4f8b\u5982\u300a\u8fd8\u73e0\u683c\u683c\u300b\uff0c\u8fd8\u6709\u300a\u94c1\u9f7f\u94dc\u7259\u7eaa\u6653\u5c9a\u300b\u7b49\uff0c\u8981\u8bf4\u522b\u4eba\u4e00\u751f\u4e13\u6ce8\u6f14\u620f\uff0c\u90a3\u4e48\u5f20\u94c1\u6797\u5c31\u662f\u4e00\u751f\u53ea\u6f14\u7687\u5e1d\u3002\u603b\u6240\u5468\u77e5\uff0c\u5f20\u94c1\u6797\u4e0d\u4ec5\u4ec5\u52a0\u5165\u82f1\u56fd\u56fd\u7c4d\uff0c\u8fd8\u5230\u5904\u7559\u60c5\u3002", "image_list": [], "datetime": "2017-12-08 12:35", "article_type": 0, "tag": "news_entertainment", "has_m3u8_video": 0, "keywords": "\u5f20\u94c1\u6797,\u9676\u8679,\u820c\u543b,\u94c1\u9f7f\u94dc\u7259\u7eaa\u6653\u5c9a,\u501a\u5929\u5c60\u9f99\u8bb0,\u7eaa\u6653\u8299,\u8fd8\u73e0\u683c\u683c,\u5f20\u6708\u4eae", "display_dt": 1512251117, "has_mp4_video": 0, "aggr_type": 1, "cell_type": 0, "article_sub_type": 0, "bury_count": 0, "title": "\u201c\u7687\u963f\u739b\u201d\u5f20\u94c1\u6797\u5230\u5e95\u6709\u591a\u672c\u8272\uff1f\u8fd9\u4ef6\u4e8b\u544a\u8bc9\u4f60", "source_icon_style": 4, "tip": 0, "has_video": false, "share_url": "http://m.toutiao.com/a6495069092075012622/?iid=0&app=news_article", "source": "\u4e09\u4e03\u504f\u5206", "comment_count": 64, "article_url": "http://toutiao.com/group/6495069092075012622/", "publish_time": 1512251117, "group_flags": 0, "middle_mode": true, "gallary_image_count": 11, "action_extra": "{\"channel_id\": 3189398972}", "tag_id": "6495069092075012622", "source_url": "/i6495069092075012622/", "display_url": "http://toutiao.com/group/6495069092075012622/", "is_stick": false, "item_id": "6495069092075012622", "repin_count": 249, "cell_flag": 11, "source_open_url": "sslocal://profile?uid=74073383301", "level": 0, "digg_count": 1, "behot_time": 1512707708, "hot": 0, "cursor": 1512707708999, "url": "http://toutiao.com/group/6495069092075012622/", "like_count": 1, "image_url": "https://p3.pstatp.com/list/4ad60001f69d434466f9", "user_repin": 0, "has_image": true, "video_style": 0, "media_info": {"avatar_url": "http://p3.pstatp.com/large/43520003302817481fd7", "media_id": 1582847668470797, "name": "\u4e09\u4e03\u504f\u5206", "user_verified": false}, "group_id": "6495069092075012622"}, {"media_name": "\u5a31\u4e50\u5343\u5343\u4e07", "ban_comment": 0, "abstract": "\u5f53\u5e74\u80e1\u6b4c\u51fa\u8f66\u7978\u540e\uff0c\u859b\u4f73\u51dd\u4e0d\u79bb\u4e0d\u5f03\u7167\u987e\u4ed6\uff0c\u53ef\u60dc\uff0c\u66fe\u7ecf\u5171\u60a3\u96be\u7684\u4e24\u4eba\u8fd8\u662f\u6ca1\u8d70\u5230\u4e00\u8d77\u3002\u540e\u6765\uff0c\u859b\u4f73\u51dd\u6bc5\u7136\u7688\u4f9d\u4f5b\u6559\uff0c\u76f4\u81f3\u4eca\u65e5\u5df2\u8db311\u4e2a\u6708\u96f617\u5929\u3002", "image_list": [{"url": "https://p3.pstatp.com/list/4af2000232f2d66c7f0d", "width": 641, "height": 360}, {"url": "https://p3.pstatp.com/list/4af40000533df2352fc2", "width": 581, "height": 312}, {"url": "https://p3.pstatp.com/list/4af30002204d9c13e4bf", "width": 586, "height": 292}], "datetime": "2017-12-08 12:34", "article_type": 0, "more_mode": true, "tag": "buddhism", "has_m3u8_video": 0, "keywords": "\u4f5b\u6559,\u80e1\u6b4c,\u859b\u4f73\u51dd", "display_dt": 1512660736, "has_mp4_video": 0, "aggr_type": 1, "cell_type": 0, "article_sub_type": 0, "bury_count": 1, "title": "\u80e1\u6b4c\u524d\u5973\u53cb\u859b\u4f73\u51dd\u5e26\u53d1\u4fee\u884c\uff0c\u5df2\u8db311\u4e2a\u6708\u96f617\u5929", "source_icon_style": 6, "tip": 0, "has_video": false, "share_url": "http://m.toutiao.com/a6496828055539941902/?iid=0&app=news_article", "source": "\u5a31\u4e50\u5343\u5343\u4e07", "comment_count": 3960, "article_url": "http://toutiao.com/group/6496828055539941902/", "publish_time": 1512660736, "group_flags": 0, "gallary_image_count": 3, "action_extra": "{\"channel_id\": 3189398972}", "tag_id": "6496828055539941902", "source_url": "/i6496828055539941902/", "display_url": "http://toutiao.com/group/6496828055539941902/", "is_stick": false, "item_id": "6496828055539941902", "repin_count": 3471, "cell_flag": 11, "source_open_url": "sslocal://profile?uid=53229221786", "level": 0, "digg_count": 2, "behot_time": 1512707641, "hot": 0, "cursor": 1512707641999, "url": "http://toutiao.com/group/6496828055539941902/", "like_count": 2, "user_repin": 0, "has_image": true, "video_style": 0, "media_info": {"avatar_url": "http://p1.pstatp.com/large/3ecc00001427f530a581", "media_id": 1580778797801485, "name": "\u5a31\u4e50\u5343\u5343\u4e07", "user_verified": false}, "group_id": "6496828055539941902"}, {"media_name": "\u6d41\u5e74\u4e0e\u6b4c", "ban_comment": 0, "abstract": "", "image_list": [{"url": "https://p3.pstatp.com/list/4add00039e18b5fb4aa6", "width": 449, "height": 252}, {"url": "https://p3.pstatp.com/list/4ada0003e209940a9552", "width": 431, "height": 242}, {"url": "https://p3.pstatp.com/list/4add00039e1e40aaadff", "width": 500, "height": 281}], "datetime": "2017-12-08 12:32", "article_type": 0, "more_mode": true, "tag": "news_entertainment", "has_m3u8_video": 0, "keywords": "\u91d1\u5531\u7247,\u62ab\u7740\u7f8a\u76ae\u7684\u72fc,\u5200\u90ce,\u8c22\u8c22\u4f60,\u738b\u5065\u6797,\u90a3\u82f1,\u8d44\u4e2d\u53bf", "display_dt": 1512381353, "has_mp4_video": 0, "aggr_type": 1, "cell_type": 0, "article_sub_type": 0, "bury_count": 0, "title": "\u5200\u90ce\u88ab\u90a3\u82f1\u77a7\u4e0d\u8d77\uff0c\u8bf4\u4ed6\u662f\u519c\u6c11\u6b4c\u624b\uff0c\u770b\u770b\u5200\u90ce\u73b0\u5728\u662f\u600e\u6837\u7684\u751f\u6d3b", "source_icon_style": 2, "tip": 0, "has_video": false, "share_url": "http://m.toutiao.com/a6495628448784990734/?iid=0&app=news_article", "source": "\u6d41\u5e74\u4e0e\u6b4c", "comment_count": 12, "article_url": "http://toutiao.com/group/6495628448784990734/", "publish_time": 1512381353, "group_flags": 131072, "gallary_image_count": 7, "action_extra": "{\"channel_id\": 3189398972}", "tag_id": "6495628448784990734", "source_url": "/i6495628448784990734/", "display_url": "http://toutiao.com/group/6495628448784990734/", "is_stick": false, "item_id": "6495628448784990734", "repin_count": 64, "cell_flag": 11, "source_open_url": "sslocal://profile?uid=52913833321", "level": 0, "digg_count": 1, "behot_time": 1512707574, "hot": 0, "cursor": 1512707574999, "url": "http://toutiao.com/group/6495628448784990734/", "like_count": 1, "user_repin": 0, "has_image": true, "video_style": 0, "media_info": {"avatar_url": "http://p9.pstatp.com/large/1355000031fdff095540", "media_id": 1553794950163458, "name": "\u6d41\u5e74\u4e0e\u6b4c", "user_verified": false}, "group_id": "6495628448784990734"}, {"media_name": "\u7b80\u7b80\u5355\u5355\u7684\u5a31\u4e50", "ban_comment": 0, "abstract": "", "image_list": [{"url": "https://p3.pstatp.com/list/4af300035f0f4f7749d4", "width": 555, "height": 312}, {"url": "https://p3.pstatp.com/list/4af200036ec03a30cf74", "width": 508, "height": 285}, {"url": "https://p3.pstatp.com/list/4af00003d05430f8d88a", "width": 600, "height": 337}], "datetime": "2017-12-08 12:31", "article_type": 0, "more_mode": true, "tag": "news_entertainment", "has_m3u8_video": 0, "display_dt": 1512698595, "has_mp4_video": 0, "aggr_type": 1, "cell_type": 0, "article_sub_type": 0, "bury_count": 0, "title": "\u6b27\u7f8e\u5927\u6d0b\u9a6c\u5973\u661f\uff0c\u4f60\u4eec\u559c\u6b22\u5417\uff1f", "source_icon_style": 1, "tip": 1, "has_video": false, "share_url": "http://m.toutiao.com/a6496990993525506574/?iid=0&app=news_article", "source": "\u7b80\u7b80\u5355\u5355\u7684\u5a31\u4e50", "comment_count": 1, "article_url": "http://toutiao.com/group/6496990993525506574/", "publish_time": 1512698595, "group_flags": 131072, "gallary_image_count": 5, "action_extra": "{\"channel_id\": 3189398972}", "tag_id": "6496990993525506574", "source_url": "/i6496990993525506574/", "display_url": "http://toutiao.com/group/6496990993525506574/", "is_stick": false, "item_id": "6496990993525506574", "repin_count": 34, "cell_flag": 11, "source_open_url": "sslocal://profile?uid=69310225244", "level": 0, "digg_count": 0, "behot_time": 1512707506, "hot": 1, "cursor": 1512707506999, "url": "http://toutiao.com/group/6496990993525506574/", "user_repin": 0, "has_image": true, "video_style": 0, "media_info": {"avatar_url": "http://p1.pstatp.com/large/3a090000751e7d72cf5b", "media_id": 1578571068704781, "name": "\u7b80\u7b80\u5355\u5355\u7684\u5a31\u4e50", "user_verified": false}, "group_id": "6496990993525506574"}, {"media_name": "\u82b1\u53d4", "ban_comment": 0, "abstract": "", "image_list": [{"url": "https://p3.pstatp.com/list/4adf00037df7b39b46e2", "width": 352, "height": 198}, {"url": "https://p3.pstatp.com/list/4ae10000582a51509948", "width": 350, "height": 196}, {"url": "https://p3.pstatp.com/list/4ae3000050f6861eec9d", "width": 500, "height": 281}], "datetime": "2017-12-08 12:30", "article_type": 0, "more_mode": true, "tag": "news_entertainment", "has_m3u8_video": 0, "keywords": "\u90b1\u6dd1\u8d1e,\u53f6\u7389\u537f,\u4e09\u7ea7\u7247,\u4e0a\u6d77\u4e00\u4e5d\u56db\u4e5d,\u9752\u697c\u5341\u4e8c\u623f,\u4ed9\u9e64\u4ed9\u9488,\u738b\u6676,\u7fc1\u8679", "display_dt": 1512405999, "has_mp4_video": 0, "aggr_type": 1, "cell_type": 0, "article_sub_type": 0, "bury_count": 1, "title": "49\u5c81\u4e09\u7ea7\u5973\u738b\u98ce\u97f5\u72b9\u5b58\uff0c\u7f51\u53cb\u8c03\u4f83\uff1a\u201c\u4e0a\u9762\u5305\u4e0d\u4f4f\u4e86\uff0c\u5feb\u8e66\u51fa\u6765\u4e86\u201d", "source_icon_style": 2, "tip": 1, "has_video": false, "share_url": "http://m.toutiao.com/a6495734304260227597/?iid=0&app=news_article", "source": "\u82b1\u53d4", "comment_count": 49, "article_url": "http://toutiao.com/group/6495734304260227597/", "publish_time": 1512405999, "group_flags": 131072, "gallary_image_count": 8, "action_extra": "{\"channel_id\": 3189398972}
    */
    let url = 'https://m.toutiao.com/list/?tag=news_entertainment&ac=wap&count=20&format=json_raw&as=A1D5FA1218ED393&cp=5A281DC3A9B39E1&min_behot_time=0';
    //let url = 'http://127.0.0.1:7001/article';
    // 返回结果
    let result = '';
    let getArticleIndexFlag = await this.getArticleIndexFlag();
    // 标志位存在  读取缓存
    if(getArticleIndexFlag){
      let articleIndexDetail = await this.getArticleIndexDetail();
      result = articleIndexDetail;
    }else{// 标志位过期  重新抓取数据
      try{
        let urlData = await this.timesGetUrlData(url);
        if(urlData){
          result = JSON.parse(urlData);
          // 首页文章过期时间 7天
          let detailExpireTime = 604800;
          // 标志位过期时间 20分钟
          let flagExpireTime = 1200;
          this.setArticleIndexDetail(urlData,detailExpireTime);
          this.setArticleIndexFlag(flagExpireTime); 
        }
      }catch(err){
        console.error(err);
        console.log('数据解析错误，数据格式可能发生变化');
      }
    }
    
    
    console.log('首页数据返回:'+JSON.stringify(result));

    return result;
  }

  async list2() {
    //明星code码
    let code = 1001;//id;
    let starName = await this.getStarName(code);

    let articleRedisData = await this.getArticleStarDetailByScore(code,10);

    for(let k in articleRedisData){
      articleRedisData[k] = JSON.parse(articleRedisData[k]);
    }

    return articleRedisData;
  }

  async detail(id) {
    //const article = this.app.knex.first('*').where('id',id).from('t_news');
    
    //return article;
    //明星code码
    let code = 1001;//id;
    let starName = await this.getStarName(code);

    let articleRedisData = await this.getArticleStarDetailByScore(code,2);

    if(articleRedisData){
      for(let k in articleRedisData){
        articleRedisData[k] = JSON.parse(articleRedisData[k]);
      }

      return articleRedisData;
    }else{
      let url = 'curl "https://index.toutiao.com/api/keyword/groups?keyword='+starName+'&start=20171203&end=20171209&region=0&category=0" --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36"';
      //let url = 'http://127.0.0.1:7001/article';

      let curlData = await child_process.execSync(url,{encoding:'utf-8'});
    //curlData = JSON.stringify(curlData).toS;
    
      curlData = JSON.parse(curlData);
      if(curlData  && curlData.related_articles){
        for(let i in curlData.related_articles[starName]){
          let articleData = curlData.related_articles[starName][i];
          if(articleData.publish_time){
            this.zaddArticleStarDetail(code,articleData.publish_time,articleData);  
          }
        }
      }
      
      return curlData;  
    }

    


    
    // // 返回结果
    // let result = '';
    // let getArticleIndexFlag = await this.getArticleStarFlag(code);
    // // 标志位存在  读取缓存
    // if(getArticleIndexFlag){
    //   let articleIndexDetail = await this.getArticleStarDetail(code);
    //   result = articleIndexDetail;
    // }else{// 标志位过期  重新抓取数据
    //   try{
    //     let urlData = await this.timesGetUrlData(url);
    //     if(urlData){
    //       result = JSON.parse(urlData);
    //       // 首页文章过期时间 7天
    //       let detailExpireTime = 604800;
    //       // 标志位过期时间 20分钟
    //       let flagExpireTime = 1200;
    //       this.setArticleStarDetail(urlData,code,detailExpireTime);
    //       this.setArticleStarFlag(code,flagExpireTime); 
    //     }
    //   }catch(err){
    //     console.error(err);
    //     console.log('数据解析错误，数据格式可能发生变化');
    //   }
    // }

    
    
    
    //console.log('首页数据返回:'+JSON.stringify(result));

    //return result;

  }

  async banner(){
      let list = this.app.knex.select('tta.title', 'tta.sub_title', 'tta.summary','tta.url','tta.sort','ttb.url as image_url')
            .from('t_news as tta').leftJoin('t_news_image as ttb', 'tta.id', 'ttb.news_id')
            .where({'tta.categories_id':1,'tta.delete_flag':0,'ttb.delete_flag':0}).orderBy('tta.sort').limit(4);
      return list;
  }

  async getStarName(code){

    return '黄晓明';
  }

  // 获取首页新闻标志位 用来判断是否需要重新抓取
  async getArticleIndexFlag(){
    let key = articleRedisKey.ARTICLE_INDEX_FALG;

    return this.app.redis.get(key);
  }
  // 设置首页新闻标志位 用来判断是否需要重新抓取
  async setArticleIndexFlag(expireTime){
    let key = articleRedisKey.ARTICLE_INDEX_FALG;

    return this.app.redis.set(key,1,'EX',expireTime);
  }

  // 获取首页新闻详情 
  async getArticleIndexDetail(){
    let key = articleRedisKey.ARTICLE_INDEX_DETAIL;
    let result = await this.app.redis.get(key);
    return JSON.parse(result);
  }
  // 设置首页新闻详情
  async setArticleIndexDetail(value,expireTime){
    let key = articleRedisKey.ARTICLE_INDEX_DETAIL;

    return this.app.redis.set(key,value,'EX',expireTime);
  }

  // 获取明星新闻标志位 用来判断是否需要重新抓取
  async getArticleStarFlag(code){
    let key = articleRedisKey.ARTICLE_STAR_FALG + code;

    return this.app.redis.get(key);
  }
  // 设置明星新闻标志位 用来判断是否需要重新抓取
  async setArticleStarFlag(expireTime){
    let key = articleRedisKey.ARTICLE_STAR_FALG + code;

    return this.app.redis.set(key,1,'EX',expireTime);
  }

  // 获取明星新闻详情 
  async getArticleStarDetail(code){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;
    let result = await this.app.redis.get(key);
    return JSON.parse(result);
  }
  // 添加一个新闻详情
  async zaddArticleStarDetail(code,score,value){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;

    return this.app.redis.zadd(key,score,JSON.stringify(value));
  }
  //倒叙获取最近新闻
  async getArticleStarDetailByScore(code,iCount){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;

    return this.app.redis.zrevrange(key,0,iCount-1);
  }

  //获取新闻长度
  async getArticleStarDetailCount(code){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;

    return this.app.redis.zcard(key,0,iCount);
  }

  //删除老的新闻
  async delArticleStarDetailByScore(code,iCount){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;

    return this.app.redis.zremrangebybank(key,0,iCount-1);
  }





  // 设置明星新闻详情
  async setArticleStarDetail(value,code,expireTime){
    let key = articleRedisKey.ARTICLE_STAR_DETAIL + code;

    return this.app.redis.set(key,value,'EX',expireTime);
  }

  // 多次重复抓取数据  针对容易失败情况
  async timesGetUrlData(url){
    let urlData = false;
    let iCount = 0;
    while(!urlData && iCount <10 ){
      urlData = await this.getUrlDataByHttps(url);
      console.log('失败尝试次数:'+iCount);
      iCount++;
    }

    return urlData;
  }
  // 抓取网页数据 http 协议
  async getUrlDataByHttps(url){
    return new Promise(function (resolve,reject) {  
        console.log('正在爬取 ' + url + '\n'); 
        https.get(url,function(res){  
            let html = '';  
  
            res.on('data',function (data) {  
                html += data;  
            })  
            res.on('end',function(){  
              console.log(html+' ---------抓取的数据------');
                resolve(html);//把当前的获取到页面的html返回回去（传递下去）  
            })  
  
        }).on('error',function (e) {  
            reject(e);  
            console.log("获取课程数据出错！");  
        })  
    })  

  }

}

module.exports = ArticleService
