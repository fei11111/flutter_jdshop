class Config {
  static String domain = "http://jd.itying.com/";

  ///轮播图
  static String getFocus() {
    return Config.domain + "api/focus";
  }

  ///猜你喜欢
  static String getLikeProductList() {
    return Config.domain + "api/plist?is_hot=1";
  }

  ///热门推荐
  static String getHotProductList() {
    return Config.domain + "api/plist?is_best=1";
  }

  ///商品列表
  static String getProductList(String id, int page, String sort, int pageSize) {
    return Config.domain +
        "api/plist?cid=$id&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///商品列表
  static String getProductListByKeyWords(
      String keyWords, int page, String sort, int pageSize) {
    return Config.domain +
        "api/plist?search=$keyWords&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///分类左侧
  static String getCateLeft() {
    return Config.domain + "api/pcate";
  }

  ///分类右侧
  static String getCateRight(String id) {
    return Config.domain + "api/pcate?pid=$id";
  }

  ///商品详情
  static String getProductDetail(String id) {
    return Config.domain + "api/pcontent?id=$id";
  }

  ///商品详情网页
  static String getProductDetailWeb(String id) {
    return Config.domain + "pcontent?id=$id";
  }

  ///发送验证码
  static String getCode() {
    return Config.domain + "api/sendCode";
  }

  ///验证手机号码
  static String getPhoneExp() {
    return r"^[1][2,3,4,5,6,7,8,9][0-9]{9}$";
  }

  ///验证码
  static String getValidateCode() {
    return Config.domain + "api/validateCode";
  }

  ///注册
  static String getRegister() {
    return Config.domain + "api/register";
  }

  ///登录
  static String getLogin() {
    return Config.domain + "api/doLogin";
  }
}
