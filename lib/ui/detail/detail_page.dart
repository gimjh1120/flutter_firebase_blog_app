import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          iconButton(Icons.delete, () {
            print('삭제 아이콘 터치');
          }),
          iconButton(
            Icons.edit,
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WritePage();
              }));
              print('수정 아이콘 터치');
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 500),
        children: [
          Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today I Learned',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  '이지원',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '2024.08.08 20:30',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Flutter 그리드 뷰를 배웠습니다.' * 10,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget iconButton(IconData icon, void Function() ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.transparent,
      child: Icon(icon),
    ),
  );
}
