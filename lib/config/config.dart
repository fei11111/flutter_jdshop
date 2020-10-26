class Config {
  static String domain = "http://jd.itying.com/";
  static String phoneExp = r"^[1][2,3,4,5,6,7,8,9][0-9]{9}$";

  ///轮播图
  static String getFocus() {
    return "api/focus";
  }

  ///猜你喜欢
  static String getLikeProductList() {
    return "api/plist?is_hot=1";
  }

  ///热门推荐
  static String getHotProductList() {
    return "api/plist?is_best=1";
  }

  ///商品列表
  static String getProductList(String id, int page, String sort, int pageSize) {
    return 
        "api/plist?cid=$id&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///商品列表
  static String getProductListByKeyWords(
      String keyWords, int page, String sort, int pageSize) {
    return 
        "api/plist?search=$keyWords&page=$page&sort=$sort&pageSize=$pageSize";
  }

  ///分类左侧
  static String getCateLeft() {
    return "api/pcate";
  }

  ///分类右侧
  static String getCateRight(String id) {
    return "api/pcate?pid=$id";
  }

  ///商品详情
  static String getProductDetail(String id) {
    return "api/pcontent?id=$id";
  }

  ///商品详情网页
  static String getProductDetailWeb(String id) {
    return "pcontent?id=$id";
  }

  ///发送验证码
  static String getCode() {
    return "api/sendCode";
  }

  ///验证码
  static String getValidateCode() {
    return "api/validateCode";
  }

  ///注册
  static String getRegister() {
    return "api/register";
  }

  ///登录
  static String getLogin() {
    return "api/doLogin";
  }

  ///获取用户默认地址
  static String getDefaultAddress(String uid, String sign) {
    return 'api/oneAddressList?uid=$uid&sign=$sign';
  }

  ///获取收货地址
  static String getAddressList(String uid, String sign) {
    return "api/addressList?uid=$uid&sign=$sign";
  }

  ///新增收货地址
  static String getAddAddress() {
    return "api/addAddress";
  }

  ///修改默认收货地址
  static String getChangeDefaultAddress() {
    return 'api/changeDefaultAddress';
  }

  ///修改收货地址
  static String getEditAddress() {
    return "api/editAddress";
  }

  ///删除收货地址
  static String getDeleteAddress() {
    return "api/deleteAddress";
  }

  ///提交订单
  static String getDoOrder() {
    return 'api/doOrder';
  }

  ///订单列表
  static String getOrderList(String uid, String sign) {
    return 'api/orderList?uid=$uid&sign=$sign';
  }
}
