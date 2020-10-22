import 'package:flutter/material.dart';
import 'package:flutter_jdshop/models/address_model.dart';
import 'package:flutter_jdshop/providers/address_provider.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/no_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<AddressModel> _list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _list = context.watch<AddressProvider>().addressList;
    return Scaffold(
        appBar:
            AppBar(title: Text("收货地址列表"), elevation: 0.0, centerTitle: true),
        body: Stack(
          children: [
            _list.length > 0
                ? Padding(
                    padding: EdgeInsets.only(bottom: 78.h),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container();
                        }))
                : NoDataWidget(),
            Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    buttonColor: Colors.red,
                    buttonText: "新增",
                    tap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    }))
          ],
        ));
  }
}
