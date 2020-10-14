import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
    debugPrint("ProductDetailMiddle initState");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: InAppWebView(
            initialUrl: Config.getProductDetailWeb(widget.arguments['id']),
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
            )),
            onWebViewCreated: (InAppWebViewController controller) {},
            onLoadStart: (InAppWebViewController controller, String url) {
              setState(() {});
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              setState(() {});
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(() {
                // this.progress = progress / 100;
              });
            },
          ),
        ),
      )
    ]);
  }
}
