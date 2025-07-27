import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://hagenbergapp-default-rtdb.firebaseio.com')
      .ref();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, String>>> getEvents() async {
    DatabaseEvent event = await _databaseReference.child('events').once();
    List<Map<String, String>> events = [];
    if (event.snapshot.value != null) {
      (event.snapshot.value as Map).forEach((key, value) {
        Map<String, String> event = {};
        (value as Map).forEach((k, v) {
          event[k.toString().trim()] = v.toString().trim();
        });
        events.add(event);
      });
    }
    return events;
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _databaseReference
          .child('users')
          .child(userCredential.user!.uid)
          .set({
        'email': email,
        'uid': userCredential.user!.uid,
      });
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<Map<String, String>>> getFavoriteActivities() async {
    User? user = _auth.currentUser;
    if (user == null) return [];
    DatabaseEvent event = await _databaseReference
        .child('users')
        .child(user.uid)
        .child('favorites')
        .once();
    List<Map<String, String>> favorites = [];
    if (event.snapshot.value != null) {
      (event.snapshot.value as Map).forEach((key, value) {
        Map<String, String> activity = {};
        (value as Map).forEach((k, v) {
          activity[k.toString().trim()] = v.toString().trim();
        });
        activity['id'] = key;
        favorites.add(activity);
      });
    }
    return favorites;
  }

  Future<void> addToFavorites(Map<String, String> activity) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DatabaseEvent event = await _databaseReference
        .child('users')
        .child(user.uid)
        .child('favorites')
        .once();
    bool exists = false;
    if (event.snapshot.value != null) {
      (event.snapshot.value as Map).forEach((key, value) {
        if (value['name'] == activity['name']) {
          exists = true;
        }
      });
    }

    if (!exists) {
      String favoriteId = _databaseReference
              .child('users')
              .child(user.uid)
              .child('favorites')
              .push()
              .key ??
          '';
      await _databaseReference
          .child('users')
          .child(user.uid)
          .child('favorites')
          .child(favoriteId)
          .set(activity);
    }
  }

  Future<void> removeFromFavorites(String activityName) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    DatabaseEvent event = await _databaseReference
        .child('users')
        .child(user.uid)
        .child('favorites')
        .once();

    if (event.snapshot.value != null) {
      (event.snapshot.value as Map).forEach((key, value) {
        if (value['name'] == activityName) {
          _databaseReference
              .child('users')
              .child(user.uid)
              .child('favorites')
              .child(key)
              .remove();
        }
      });
    }
  }
}
