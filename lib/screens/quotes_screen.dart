import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/models/quote_model.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:http/http.dart' as http;

class QuotesScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<QuotesScreen> {
  /**
   * Используя бесплатное API для получения цитат (https://api.quotable.io/random),
   * реализуйте асинхронный метод 'fetchQuote' для получения случайной цитаты.
   */
  Future<http.Response> fetchUser() {
    return http.get(Uri.parse('https://johndturn-quotableapiproxy.web.val.run/'));
  }

  Future<void> showRandomUser() async {
    try {
      final response = await fetchUser();

      if (response.statusCode == 200) {
        var quote = Quote.fromJson(
          (jsonDecode(
            response.body
          ) as List<dynamic>)[0] ?? {}
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Случайная цитата'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Автор: " + quote.author),
                  Text("Цитата: " + quote.content),
                  Text("Теги: " + quote.tags.join(", ")),
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
            title: Text(e.toString()),
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
          "Получить случайную цитату"
        )),
      ),drawer: MyDrawer(),
    );
  }
}
