import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/models/product_detail_model.dart';
import 'package:flutter_jdshop/widget/custom_button.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailLeft extends StatefulWidget {
  final ProductDetailItemModel itemModel;

  const ProductDetailLeft({Key key, this.itemModel}) : super(key: key);

  @override
  _ProductDetailLeftState createState() => _ProductDetailLeftState();
}

class _ProductDetailLeftState extends State<ProductDetailLeft>
    with AutomaticKeepAliveClientMixin {
  ProductDetailItemModel _itemModel;
  List<String> _selectAttrs = [];

  @override
  void initState() {
    super.initState();
    debugPrint("ProductDetailLeft initState");
    _itemModel = widget.itemModel;
    _initAttrs();
  }

  void _initAttrs() {
    debugPrint("_initAttrs");
    _itemModel.attr.forEach((e) {
      for (int i = 0; i < e.list.length; i++) {
        if (i == 0) {
          e.attrList.add({"title": e.list[i], "checked": true});
        } else {
          e.attrList.add({"title": e.list[i], "checked": false});
        }
      }
    });
    _setSelectAttrs();
  }

  void _setSelectAttrs() {
    _selectAttrs.clear();
    _itemModel.attr.forEach((e) {
      for (int i = 0; i < e.attrList.length; i++) {
        if (e.attrList[i]["checked"] == true) {
          _selectAttrs.add(e.attrList[i]["title"]);
        }
      }
    });
    setState(() {
      _selectAttrs = _selectAttrs;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return Container(
      child: ListView(physics: BouncingScrollPhysics(), children: [
        Image.network("${Config.domain}${_itemModel.pic.replaceAll("\\", "/")}",
            fit: BoxFit.cover),
        Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(_itemModel.title,
                      style:
                          TextStyle(fontSize: 32.sp, color: Colors.black87))),
              Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: _itemModel.subTitle != null
                      ? Text(_itemModel.subTitle,
                          style:
                              TextStyle(fontSize: 28.sp, color: Colors.black54))
                      : Html(data: _itemModel.content)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '特价:',
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                            text: '￥${_itemModel.price}',
                            style:
                                TextStyle(fontSize: 34.sp, color: Colors.red)),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: '原价:',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 26.sp,
                              color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                                text: '￥${_itemModel.oldPrice}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 26.sp,
                                    color: Colors.black54)),
                          ],
                        ),
                      ))
                ],
              ),
              Container(
                  height: 80.h,
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(233, 233, 233, 0.8)))),
                  child: InkWell(
                      child: Row(
                        children: [
                          Text("已选:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 10.w),
                          Text(_selectAttrs.length > 0
                              ? _selectAttrs.toString()
                              : "")
                        ],
                      ),
                      onTap: () {
                        _showBottomDialog(context, _itemModel);
                      })),
              Container(
                  height: 80.h,
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(233, 233, 233, 0.8)))),
                  child: Row(
                    children: [
                      Text("运费:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      SizedBox(width: 10.w),
                      Text("免费")
                    ],
                  ))
            ]))
      ]),
    );
  }

  ///确认dialog
  void _showBottomDialog(context, ProductDetailItemModel model) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Stack(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 90.h),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: ListView.builder(
                      itemCount: model.attr.length,
                      itemBuilder: (context, index) {
                        return Row(children: [
                          Text("${model.attr[index].cate}:"),
                          Wrap(
                            children: model.attr[index].list.map((e) {
                              return Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Chip(
                                          label: Text(e.toString(),
                                              style: TextStyle(
                                                  color:
                                                      _selectAttrs.contains(e)
                                                          ? Colors.white
                                                          : Colors.black)),
                                          padding: EdgeInsets.all(10.w),
                                          backgroundColor:
                                              _selectAttrs.contains(e)
                                                  ? Colors.red
                                                  : Color.fromRGBO(
                                                      233, 233, 233, 0.8)),
                                      onTap: () {
                                        model.attr[index].attrList
                                            .forEach((element) {
                                          if (element["title"] == e) {
                                            element["checked"] = true;
                                          } else {
                                            element["checked"] = false;
                                          }
                                        });
                                        setState(() {
                                          model.attr = model.attr;
                                        });
                                        _setSelectAttrs();
                                      }));
                            }).toList(),
                          )
                        ]);
                      },
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton("确认", Colors.red, () {
                    Navigator.pop(context);
                  }))
            ]);
          });
        });
  }
}
