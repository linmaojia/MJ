


//本地环境
#define LocalEnvironment

//正式环境
//#define OfficialEnvironment
/**
 *  APIURL 服务器地址
 */

#ifdef LocalEnvironment
#define APIURL              @"http://192.168.0.62:9500"
#endif

#ifdef OfficialEnvironment
#define APIURL              @"https://ezgapi.edsmall.cn"
#endif

#pragma mark **************** 个人信息

//发送验证码到手机
#define APISendMobile               [APIURL stringByAppendingString:@"/v1/send/"]

/*开眼首页url 拼接*/
#define APIUrlStr @"&_s=30d8d9d3fae1e61f2edb713ee13f0269&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=40d3136acca8108e4d0984a289c93000e44dd89a&v=2.9.0&vc=1604"

#define APIHomeTop @"http://baobab.kaiyanapp.com/api/v3/tabs/selected?_s=ca691ec180043feebbe9771142d10ab8&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=40d3136acca8108e4d0984a289c93000e44dd89a&v=2.9.0&vc=1604"

#define APIFindUrl @"http://baobab.kaiyanapp.com/api/v3/discovery?_s=01b25d4b019e85a19771c4e890da45a7&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=40d3136acca8108e4d0984a289c93000e44dd89a&v=2.9.0&vc=1604"


#define MyEnFontTwo @"Lobster 1.4"

#define MyChinFont @"FZLTZCHJW--GB1-0"

#define MyChinFontTwo @"FZLTXIHJW--GB1-0"

#define MyEnFont @"Chalkduster"


