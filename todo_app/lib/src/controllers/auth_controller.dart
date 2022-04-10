import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/src/models/user_model.dart';

class AuthController with ChangeNotifier {
  final Box accountsCache = Hive.box('accounts');
  final Box currentUserCache = Hive.box('current_user');
  User? currentUser;
  List<User> users = [];

  AuthController() {
    var cresult =
        currentUserCache.get('current_user', defaultValue: null);
    if (cresult != null) {
      currentUser = User.fromJson(Map<String, dynamic>.from(cresult));
    }
    List result = accountsCache.get('users', defaultValue: []);
    print(result);
    for (var entry in result) {
      print(entry);
      users.add(User.fromJson(Map<String, dynamic>.from(entry)));
    }
    notifyListeners();
  }

  String register(String username, String password) {
    if (userExists(username) != null) {
      //if userExist return a username
      return 'Error: the username is already taken';
    } else {
      users.add(User(username: username, password: password));
      saveDataToCache();
      return "User Successfully registered";
    }
  }

  bool login(String username, String password) {
    User? userSearchResult = userExists(username);
    if (userSearchResult != null) {
      //if userSearchResult value is NOT NULL (username must exists)
      bool result = userSearchResult.login(username, password);
      if (result) {
        currentUser = userSearchResult;
        currentUserCache.put('current_user', currentUser!.toJson());
        notifyListeners();
      }
      return result;
    } else {
      return false;
    }
  }

  logout() {
    currentUser = null;
    currentUserCache.put('current_user', null);
    notifyListeners();
  }

  User? userExists(String username) {
    for (User user in users) {
      if (user.exists(username)) return user;
    }
    return null;
  }

  saveDataToCache() {
    List<Map<String, dynamic>> dataToStore = [];
    for (User user in users) {
      dataToStore.add(user.toJson());
    }
    print(dataToStore);
    accountsCache.put('users', dataToStore);
    notifyListeners();
  }
}
