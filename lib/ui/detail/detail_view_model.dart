import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//1. 상태 클래스 만들기
//post 객체를 사용해서 만들지 않음
//2. 뷰모델 만들기

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  @override
  Post build(Post arg) {
    listenStream();
    return arg;
  }

  final postRepository = PostRepository();

  Future<bool> deletePost() async {
    return postRepository.delete(arg.id);
  }

  void listenStream() {
    final stream = postRepository.postStream(arg.id);
    final streamSub = stream.listen((data) {
      if (data != null) {
        state = data;
      }
    });

    ref.onDispose(() {
      streamSub.cancel();
    });
  }
}

//3. 뷰모델 관리자 만들기
final detailViewModelProvider =
    NotifierProvider.autoDispose.family<DetailViewModel, Post, Post>(
  () {
    return DetailViewModel();
  },
);
