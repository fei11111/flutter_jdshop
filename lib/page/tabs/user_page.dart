import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("user initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text("我的"), elevation: 0.0),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
              height: 220.h,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/user_bg.jpg'),
                      fit: BoxFit.cover)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    width: 100.w,
                    height: 100.h,
                    child: CircleAvatar(
                        backgroundImage: AssetImage('images/user.png')),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("用户名：124124125",
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.sp)),
                      Text("普通会员",
                          style:
                              TextStyle(color: Colors.white, fontSize: 24.sp))
                    ],
                  )
                ],
              )),
          ListTile(
              leading: Icon(Icons.assignment, color: Colors.red),
              title: Text("全部订单")),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment, color: Colors.green),
              title: Text("待付款")),
          Divider(),
          ListTile(
              leading: Icon(Icons.local_car_wash, color: Colors.orange),
              title: Text("待收货")),
          Container(
              width: double.infinity,
              height: 20.h,
              color: Color.fromRGBO(242, 242, 242, 0.9)),
          ListTile(
              leading: Icon(Icons.favorite, color: Colors.lightGreen),
              title: Text("我的收藏")),
          Divider(),
          ListTile(
              leading: Icon(Icons.people, color: Colors.black54),
              title: Text("在线客服")),
          Divider(),
        ],
      ),
    );
  }
}
