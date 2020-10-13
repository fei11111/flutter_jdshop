import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    debugPrint("ProductDetailMiddle initState");
  }

  @override
  bool get wantKeepAlive => true;

  var _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("dddd")
      // _progress < 100
      //     ? LinearProgressIndicator(minHeight: 2.h, value: _progress)
      //     : Container(),
      // Expanded(
      //     flex: 1,
      //     child: InAppWebView(
      //       initialUrl: Config.getProductDetailWeb(widget.arguments["id"]),
      //       onProgressChanged:
      //           (InAppWebViewController controller, int progress) {
      //         setState(() {
      //           _progress = progress.toDouble();
      //         });
      //       },
      //     ))
    ]);
  }
}
