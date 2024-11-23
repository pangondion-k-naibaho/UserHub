import 'package:flutter/material.dart';

import 'model/User.dart';

class Constants{
  static const String newsApiUrl = "https://newsapi.org/v2/";
  static const String APP_PREFERENCES = "APP_PREFERENCES";
  static const String TOKEN_KEY = "TOKEN_KEY";
  static const String USERNAME_KEY = "USERNAME_KEY";

  static final List<User> users = [
    User(id: 1, email: 'john@example.com', password: 'doejohnuh123', username: 'John Doe'),
    User(id: 2, email: 'jane@example.com', password: 'smithjaneuh123', username: 'Jane Smith'),
    User(id: 3, email: 'michael@example.com', password: 'johnsonmichaeluh123', username: 'Michael Johnson'),
  ];

  static List<User> getListUser(){
    return users;
  }

}