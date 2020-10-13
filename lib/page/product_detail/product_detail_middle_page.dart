import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_jdshop/config/config.dart';

class ProductDetailMiddle extends StatefulWidget {
  final Map arguments;

  const ProductDetailMiddle({Key key, this.arguments}) : super(key: key);

  @override
  _ProductDetailMiddleState createState() => _ProductDetailMiddleState();
}

class _ProductDetailMiddleState extends State<ProductDetailMiddle>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    debugPrint("ProductDetailMiddle");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Expanded(
          //   child: InAppWebView(
          //     initialUrl: Config.getProductDetailWeb(widget.arguments["id"]),
          //     onProgressChanged:
          //         (InAppWebViewController controller, int progress) {},
          //   ),
          // )
        ],
      ),
    );
  }
}
