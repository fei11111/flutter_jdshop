import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/sp.dart';
import 'package:flutter_jdshop/utils/sp_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyWords;

  @override
  void initState() {
    super.initState();
    _getHistorySearchData();
  }

  void _getHistorySearchData() async {
    List<String> list = await SPUtil.getStringList(SP.searchKey);
    if (list == null) {
      list = [];
    }
    await SPUtil.setStringList(SP.searchKey, list);
    setState(() {
      _historySearchList = list;
    });
  }

  List<String> _hotSearchList = [
    "女装",
    "男装",
    "电脑",
    "超级秒杀",
    "宝宝汽车",
    "女装",
    "男装",
    "西装",
    "裙子0",
  ];

  List<String> _historySearchList = [];

  Widget _getAppBarWidget() {
    return AppBar(
      elevation: 1.0,
      titleSpacing: 0.0,
      title: Container(
        height: 65.h,
        padding: EdgeInsets.only(left: 15.w),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30.w)),
        child: TextField(
          autofocus: false,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintText: "输入搜索关键字",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none)),
          onChanged: (String value) {
            setState(() {
              _keyWords = value;
            });
          },
        ),
      ),
      actions: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: InkWell(
                child: Text("搜索"),
                onTap: () {
                  if (_keyWords == null || _keyWords.isEmpty) return;
                  Navigator.pushNamed(context, "/productList",
                      arguments: {"keyWords": _keyWords});
                  if (!_historySearchList.contains(_keyWords)) {
                    _historySearchList.add(_keyWords);
                    SPUtil.setStringList(SP.searchKey, _historySearchList);
                    setState(() {
                      _historySearchList = _historySearchList;
                    });
                  }
                }))
      ],
    );
  }

  ///热搜
  Widget _getHotSearchWidget() {
    return Wrap(
      children: _hotSearchList.map((e) {
        return Container(
          margin: EdgeInsets.only(left: 10.w, bottom: 20.h, right: 10.w),
          padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
          decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, 0.8)),
          child: Text(e.toString(), style: TextStyle(color: Colors.black54)),
        );
      }).toList(),
    );
  }

  ///历史搜索
  Widget _getHistorySearchWidget() {
    return Container(
        child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _historySearchList.length,
      itemBuilder: (context, index) {
        return InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.w,
                          color: Color.fromRGBO(233, 233, 233, 0.8)))),
              child: Text(_historySearchList[index]),
            ),
            onLongPress: () {
              _showDeleteDialog(context, _historySearchList[index]);
            },
            onTap: () {
              Navigator.pushNamed(context, "/productList",
                  arguments: {"keyWords": _historySearchList[index]});
            });
      },
    ));
  }

  void _showDeleteDialog(context, String keyWord) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息！"),
            content: Text("您确定要删除吗？"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, "cancel");
                  },
                  child: Text("取消")),
              FlatButton(
                  onPressed: () {
                    if (_historySearchList.contains(keyWord)) {
                      _historySearchList.remove(keyWord);
                      SPUtil.setStringList(SP.searchKey, _historySearchList);
                    }
                    setState(() {
                      _historySearchList = _historySearchList;
                    });
                    Navigator.pop(context, "ok");
                  },
                  child: Text("确定"))
            ],
          );
        });
  }

  Widget _getClearHistoryWidget() {
    return Container(
        height: 80.h,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 45.w, right: 45.w),
        child: OutlineButton(
          borderSide:
              BorderSide(color: Color.fromRGBO(233, 233, 233, 0.8), width: 2.w),
          onPressed: () async {
            _historySearchList.clear();
            if (await SPUtil.remove(SP.searchKey)) {
              setState(() {
                _historySearchList = _historySearchList;
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.delete_outline), Text("清空历史搜索")],
          ),
        ));
  }

  ///主体上部分布局
  Widget _getBodyTopWidget() {
    return Container(
        margin: EdgeInsets.only(bottom: 90.h),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.w, bottom: 10.h),
              child: Text("热搜", style: Theme.of(context).textTheme.headline6),
            ),
            _getHotSearchWidget(),
            Divider(
                height: 40.h,
                thickness: 30.h,
                color: Color.fromRGBO(233, 233, 233, 0.8)),
            Container(
              margin: EdgeInsets.only(left: 20.w, bottom: 10.h, top: 10.h),
              padding: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.w,
                          color: Color.fromRGBO(233, 233, 233, 0.8)))),
              child: Text("历史搜索", style: Theme.of(context).textTheme.headline6),
            ),
            _getHistorySearchWidget()
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBarWidget(),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.all(10.w),
          child: Stack(
            children: [
              _getBodyTopWidget(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: _getClearHistoryWidget())
            ],
          ),
        ));
  }
}
