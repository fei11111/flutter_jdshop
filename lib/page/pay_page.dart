import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///支付页码
class PayPage extends StatefulWidget {
  final Map arguments;

  const PayPage({Key key, this.arguments}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  String _orderId;
  String _allPrice;
  List _list = [
    {
      "title": "支付宝支付",
      "checked": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "checked": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  @override
  void initState() {
    super.initState();
    _orderId = widget.arguments['order_id'];
    _allPrice = widget.arguments['all_price'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, elevation: 0.0, title: Text("去支付")),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 78.h),
                child: ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(233, 233, 233, 0.8),
                                      width: 1))),
                          child: ListTile(
                              leading: Image.network(_list[index]['image'],
                                  fit: BoxFit.cover),
                              title: Text(_list[index]['title']),
                              trailing: _list[index]['checked']
                                  ? Icon(Icons.check)
                                  : SizedBox(),
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < _list.length; i++) {
                                    _list[i]['checked'] = false;
                                  }
                                  _list[index]['checked'] = true;
                                });
                              }));
                    })),
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    buttonColor: Colors.red,
                    buttonText: "支付",
                    tap: () {
                      debugPrint("支付");
                    }))
          ],
        ));
  }
}
