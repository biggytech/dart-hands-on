import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/models/random_user_model.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:http/http.dart' as http;

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  /**
   * Используя бесплатное API для получения пользователей,
   * реализуйте асинхронный метод 'fetchUser' для получения случайного пользователя
   */
  Future<http.Response> fetchUser() {
    // TODO: flutter pub add http
    return http.get(Uri.parse('https://randomuser.me/api/'));
  }

  Future<void> showRandomUser() async {
    try {
      final response = await fetchUser();

      if (response.statusCode == 200) {
        var user = RandomUser.fromJson(
          jsonDecode(
            response.body?.results?.toList()[0]
          ) as Map<String, dynamic>
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Случайный пользователь'),
              content: Column(
                children: [
                  Text("Пол: " + user.gender),
                  Text("Имя: " + user.firstName),
                  Text("Фамилия: " + user.lastName),
                ],
              ),
              actions: [],
            );
          },
        );
      } else {
        throw Exception("Ошибка запроса");
      }
    } catch (e) {
      print("Ошибка");
      print(e);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка парсинга'),
            actions: [],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Асинхронщина'),
        actions: [],
      ),
      body: Center(
        child: OutlinedButton(onPressed: () {
          showRandomUser();
        }, child: Text(
          "Получить случайного пользователя"
        )),
      ),drawer: MyDrawer(),
    );
  }
}
