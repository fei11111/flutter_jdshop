class Config {
  static String DOMAIN = "http://jd.itying.com/";
  static String PHONE_EXP = r"^[1][2,3,4,5,6,7,8,9][0-9]{9}$";

  ///轮播图
  static String getFocus() {
    return Config.DOMAIN + "api/focus";
  }

  ///猜你喜欢
  static String getLikeProductList() {
    return Config.DOMAIN + "api/plist?is_hot=1";
  }

  ///热门推荐
  static String getHotProductList() {
    return Config.DOMAIN + "api/plist?is_best=1";
  }

  ///商品列表
  static String getProductList(String id, int page, String sort, int pageSize) {
    return Config.DOMAIN +
        "api/plist?cid=$id&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///商品列表
  static String getProductListByKeyWords(
      String keyWords, int page, String sort, int pageSize) {
    return Config.DOMAIN +
        "api/plist?search=$keyWords&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///分类左侧
  static String getCateLeft() {
    return Config.DOMAIN + "api/pcate";
  }

  ///分类右侧
  static String getCateRight(String id) {
    return Config.DOMAIN + "api/pcate?pid=$id";
  }

  ///商品详情
  static String getProductDetail(String id) {
    return Config.DOMAIN + "api/pcontent?id=$id";
  }

  ///商品详情网页
  static String getProductDetailWeb(String id) {
    return Config.DOMAIN + "pcontent?id=$id";
  }

  ///发送验证码
  static String getCode() {
    return Config.DOMAIN + "api/sendCode";
  }

  ///验证码
  static String getValidateCode() {
    return Config.DOMAIN + "api/validateCode";
  }

  ///注册
  static String getRegister() {
    return Config.DOMAIN + "api/register";
  }

  ///登录
  static String getLogin() {
    return Config.DOMAIN + "api/doLogin";
  }

  ///获取用户默认地址
  static String getDefaultAddress(String uid, String sign) {
    return Config.DOMAIN + 'api/oneAddressList?uid=$uid&sign=$sign';
  }

  ///获取收货地址
  static String getAddressList(String uid, String sign) {
    return Config.DOMAIN + "api/addressList?uid=$uid&sign=$sign";
  }

  ///新增收货地址
  static String getAddAddress() {
    return Config.DOMAIN + "api/addAddress";
  }

  ///修改默认收货地址
  static String getChangeDefaultAddress() {
    return Config.DOMAIN + 'api/changeDefaultAddress';
  }

  ///修改收货地址
  static String getEditAddress() {
    return Config.DOMAIN + "api/editAddress";
  }

  ///删除收货地址
  static String getDeleteAddress() {
    return Config.DOMAIN + "api/deleteAddress";
  }
}
