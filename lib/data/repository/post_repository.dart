import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';

class PostRepository {
  Future<List<Post>?> getAll() async {
    try {
      //1. 파이어스토어 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      //2. 콜렉션 참조 만들기
      final collecttionRef = firestore.collection('posts');
      //3. 값 불러오기
      final result = await collecttionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        doc.id;
        final newMap = {
          'id': doc.id,
          ...map,
        };
        return Post.formJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //1. creat : 데이터쓰기
  Future<bool> insert({
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
  }) async {
    try {
      //1) 파이어스토어 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      //2) 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      //3) 문서 참조 만들기
      final docRef = collectionRef.doc();
      //4) 값 쓰기
      await docRef.set({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //2. read : 특정ID로 하나의 Document 가져오기
  Future<Post?> getOne(String id) async {
    try {
      //1) 파이어베이스 파이어스토어 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      //2) 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      //3) 문서 참조 만들기
      final docRef = collectionRef.doc(id);
      //4) 데이터 가져오기
      final doc = await docRef.get();
      return Post.formJson({
        'id': doc.id,
        ...doc.data()!,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  //3. update : Document 수정
  Future<bool> update({
    required String id,
    required String writer,
    required String title,
    required String content,
    required String imageUrl,
  }) async {
    try {
      //1) firestor 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      //2) 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      //3) 문서 참고 만들기
      final docRef = collectionRef.doc(id);
      //4) 값을 업데이트 해주기(set매서드 => update 매서드)
      //업데이트할 값 Map 형태로 넣어주기: id에 해당하는 문서가 없을 때 새로 생성
      // docRef.set(data);
      //업데이트할 값 Map 형태로 넣어주기: id에 해당하는 문서가 없을 때 에러 발생
      await docRef.update({
        'writer': writer,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //4. delete : Document 삭제
  Future<bool> delete(String id) async {
    try {
      final firestor = FirebaseFirestore.instance;
      final collectionRef = firestor.collection('posts');
      final docRef = collectionRef.doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Post>> postListStream() {
    final firestore = FirebaseFirestore.instance;
    final collectionRef =
        firestore.collection('posts').orderBy('createdAt', descending: true);
    //stream <-
    final stream = collectionRef.snapshots();
    final newStream = stream.map(
      (event) {
        return event.docs.map((e) {
          return Post.formJson({
            'id': e.id,
            ...e.data(),
          });
        }).toList();
      },
    );

    return newStream;
  }

  Stream<Post?> postStream(String id) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('posts');
    final docRef = collectionRef.doc(id);
    final stream = docRef.snapshots();
    final newStream = stream.map((e) {
      if (e.data() == null) {
        return null;
      }
      return Post.formJson({
        'id': e.id,
        ...e.data()!,
      });
    });
    return newStream;
  }
}
