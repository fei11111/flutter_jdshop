import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        width: 1.0.w)),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              "https://www.itying.com/images/flutter/list1.jpg",
                              fit: BoxFit.cover,
                            ))),
                    Text(
                      "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
//                    SizedBox(height: 10.w),
//                    Stack(
//                      children: [
//                        Align(
//                          alignment: Alignment.topLeft,
//                          child: Text(
//                            "¥198.0",
//                            style: TextStyle(color: Colors.red, fontSize: 16.0),
//                          ),
//                        ),
//                        Align(
//                          alignment: Alignment.topRight,
//                          child: Text(
//                            "¥299.0",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontSize: 14.0,
//                                decoration: TextDecoration.lineThrough),
//                          ),
//                        )
//                      ],
//                    )
                  ],
                ),
              );
            }));
  }
}
