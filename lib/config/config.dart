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
}
