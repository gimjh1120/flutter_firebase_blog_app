import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//1. 상태 클래스 만들기

class WirteState {
  bool isWriting;
  WirteState(this.isWriting);
}

//2. 뷰 모델 만들기
class WirteViewModel extends AutoDisposeFamilyNotifier<WirteState, Post?> {
  @override
  WirteState build(Post? arg) {
    return WirteState(false);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    final postRepository = PostRepository();

    state = WirteState(true);

    if (arg == null) {
      //포스트 객체가 널이면: 새로작성
      final result = await postRepository.insert(
        title: title,
        content: content,
        writer: writer,
        imageUrl: 'https://picsum.photos/200/300',
      );
      Future.delayed(Duration(microseconds: 500));
      state = WirteState(false);
      return result;
    } else {
      //널이 아니면 수정
      final result = postRepository.update(
        id: arg!.id,
        title: title,
        content: content,
        writer: writer,
        imageUrl: 'https://picsum.photos/200/300',
      );
      Future.delayed(Duration(microseconds: 500));
      state = WirteState(false);
      return result;
    }
  }
}

//3. 뷰모델 관리자 만들기
final writeViewModelProvider =
    NotifierProvider.autoDispose.family<WirteViewModel, WirteState, Post?>(
  () {
    return WirteViewModel();
  },
);
