import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_view_model.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  DetailPage(this.post);

  Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModelProvider(post));

    return Scaffold(
      appBar: AppBar(
        actions: [
          iconButton(Icons.delete, () async {
            print('삭제 아이콘 터치');
            final vm = ref.read(detailViewModelProvider(post).notifier);
            final result = await vm.deletePost();
            if (result) {
              Navigator.pop(context);
            }
          }),
          iconButton(
            Icons.edit,
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WritePage(post);
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
            post.imageUrl,
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
                  post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  post.writer,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  post.createdAt.toIso8601String(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  post.content,
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
