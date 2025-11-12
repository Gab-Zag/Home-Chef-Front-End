import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> saveFavorite(String uid, Map<String, dynamic> recipe) => _db
      .collection('users')
      .doc(uid)
      .collection('favorites')
      .doc(recipe['id'])
      .set(recipe);
}
