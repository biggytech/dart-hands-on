import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/quote_model.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<QuotesScreen> {
  List<Quote> quotes = [];

  /**
   * Используя бесплатное API для получения цитат (https://api.quotable.io/random),
   * реализуйте асинхронный метод 'fetchQuote' для получения случайной цитаты.
   */
  Future<http.Response> fetchQuote() {
    return http
        .get(Uri.parse('https://johndturn-quotableapiproxy.web.val.run/'));
  }

  void showError(String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
        );
      },
    );
  }

  Future<void> saveInSharedPrefs(Quote quote, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedQuotes = prefs.getStringList('quotes') ?? [];

    String json = jsonEncode(quote.toJson());
    storedQuotes.add(json);
    await prefs.setStringList('quotes', storedQuotes);
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> showFromSharedPrefs(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> storedQuotes = await prefs.getStringList('quotes') ?? [];
      setState(() {
        quotes = storedQuotes.map((json) {
          return Quote.fromJson(jsonDecode(json));
        }).toList();
      });
    } catch (e) {
      showError(e.toString(), context);
    }
  }

  Future<void> saveInFile(Quote quote, BuildContext context) async {
    var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/quotes.json');

    List<String> storedQuotes = [];
    // Чтение данных из файла
    if (file.existsSync()) {
      String storedQuotesStr = await file.readAsString();
      storedQuotes = (jsonDecode(storedQuotesStr) as List)?.map((item) => item as String)?.toList() ?? [];
      print(storedQuotesStr);
    } else {
      await file.writeAsString("[]");
    }

    String json = jsonEncode(quote.toJson());
    storedQuotes.add(json);
    await file.writeAsString(jsonEncode(storedQuotes));
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> showFromFile(BuildContext context) async {
    try {
      var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/quotes.json');

    List<String> storedQuotes = [];
    // Чтение данных из файла
    if (file.existsSync()) {
      String storedQuotesStr = await file.readAsString();
      storedQuotes = (jsonDecode(storedQuotesStr) as List)?.map((item) => item as String)?.toList() ?? [];
      print(storedQuotesStr);
    }

      setState(() {
        quotes = storedQuotes.map((json) {
          return Quote.fromJson(jsonDecode(json));
        }).toList();
      });
    } catch (e) {
      showError(e.toString(), context);
    }
  }

  Future<void> saveInDB(Quote quote, BuildContext context) async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'demo.db');

    	// Открываем соединение с базой данных
    	Database database = await openDatabase(path, version: 1,
	  onCreate: (Database db, int version) async {
          	    // Создаем таблицу для хранения данных
               await db.execute(
                'CREATE TABLE IF NOT EXISTS quotes (_id TEXT NOT NULL, content TEXT NOT NULL, author TEXT NOT NULL, tags TEXT NOT NULL)');
        	});


// Вставляем данные в таблицу
    	await database.transaction((txn) async {
      	  await txn.rawInsert(
               'INSERT INTO quotes(_id, content,author,tags) VALUES(' +
               '"' + quote.id + '",' +
               '"' + quote.content + '", ' +
               '"' + quote.author + '", ' +
               '"' + quote.tags.join(",") + '"'
          +')');
    	});

    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> showFromDB(BuildContext context) async {
    try {
      var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'demo.db');

    	// Открываем соединение с базой данных
    	Database database = await openDatabase(path, version: 1,
	  onCreate: (Database db, int version) async {
          	    // Создаем таблицу для хранения данных
               await db.execute(
                'CREATE TABLE IF NOT EXISTS quotes (id TEXT PRIMARY KEY, content TEXT NOT NULL, author TEXT NOT NULL, tags TEXT NOT NULL)');
        	});

          // Получаем данные из таблицы
    	List<Map> list = await database.query('quotes');

      setState(() {
        quotes = list.map((json) {
          return Quote.fromJson({
            '_id': json['_id'],
            'content': json['content'],
            'author': json['author'],
            'tags': (json['tags'] as String).split(",")
          });
        }).toList();
      });
    } catch (e) {
      showError(e.toString(), context);
    }
  }

  Future<void> showRandowQuote(BuildContext context) async {
    try {
      final response = await fetchQuote();

      if (response.statusCode == 200) {
        var quote = Quote.fromJson(
            (jsonDecode(response.body) as List<dynamic>)[0] ?? {});

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
                  OutlinedButton(
                      onPressed: () {
                        saveInSharedPrefs(quote, context);
                      },
                      child: Text("Сохранить в Shared Preferences")),
                  OutlinedButton(
                      onPressed: () {
                        saveInFile(quote, context);
                      },
                      child: Text("Сохранить в файле")),
                  SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        saveInDB(quote, context);
                      }, child: Text("Сохранить в SQLite")),
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
      body: 
      Center(
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () {
                  showRandowQuote(context);
                },
                child: Text("Получить случайную цитату")),
            ElevatedButton(
                onPressed: () {
                  showFromSharedPrefs(context);
                },
                child: Text("Показать цитаты из Shared Prefs")),
            ElevatedButton(
                onPressed: () {
                  showFromFile(context);
                },
                child: Text("Показать цитаты из файла")),
            ElevatedButton(
                onPressed: () {
                  showFromDB(context);
                },
                child: Text("Показать цитаты из SQLite")),
            SizedBox(height: 20),
            quotes.isEmpty
                ? Center(
                    child: Text('Цитаты не выводятся'),
                  )
                : Expanded(child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text("Автор: " + quotes[index].author),
                          subtitle: Column(
                            children: [
                              Text("Цитата: " + quotes[index].content),
                              Text("Теги: " + quotes[index].tags.join(", "))
                            ],
                          ));
                    },
                  ),)
                
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
