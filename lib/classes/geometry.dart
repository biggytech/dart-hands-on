// импорт для константы PI
import 'dart:math' as math;
// для stdout
import 'dart:io';

// интерфейс
abstract class PerimeterCalculation {
  // интерфейс всех методов класса Square
  double calculateArea();
  double calculatePerimeter();
}

// миксин
mixin PrintDetailsMixin {
  String getDetails() {
    String result = "";

    if (this is Square) {
      var square = this as Square;
      result += "Ширина:";
      result += square.width.toString();
      result += ", Площадь:";
      result += square.calculateArea().toString();
      result += ", Периметр:";
      result += square.calculatePerimeter().toString();
    } else if (this is Rectangle) {
      var rectangle = this as Rectangle;
      result += "Ширина:";
      result += rectangle.getWidth.toString();
      result += ", Высота:";
      result += rectangle.getHeight.toString();
      result += ", Площадь:";
      result += rectangle.calculateArea().toString();
    } else if (this is Circle) {
      var circle = this as Circle;
      result += "Радиус:";
      result += circle.radius.toString();
      result += ", Площадь:";
      result += double.parse(circle.calculateArea().toStringAsFixed(5)).toString();
    } else if (this is Cube) {
      var cube = this as Cube;
      result += "Ширина:";
      result += cube.width.toString();
      result += ", Объем:";
      result += cube.calculateVolume().toString();
    } else if (this is Sphere) {
      var sphere = this as Sphere;
      result += "Радиус:";
      result += sphere.radius.toString();
      result += ", Объем:";
      result += sphere.calculateVolume().toString();
    }

    return result;
  }
}

// 2D ФИГУРЫ
abstract class Shape with PrintDetailsMixin {
  // нет тела метода - значит абстрактный
  double calculateArea();
  String getTitle();

  // метод для демонстрации
  // обработки исключений
  void brokenMehod() {
    try {
      // ~/ означает деление как целые числа
      // просто деление не упадет с ошибкой
      // будет просто бесконечность в ответе
      print(1 ~/ 0);
    } on IntegerDivisionByZeroException catch(e) {
      print("Division by 0");
    } catch (e) {
      print("Unknown error");
    }
  }
}

// квадрат
class Square extends Shape implements PerimeterCalculation {
  final double width;

  // конструктор с именованными параметрами
  Square({ required this.width }) {
    if (width == 0) {
      throw "0 width not allowed!";
    }
  }

  // именованный конструктор
  Square.fromWidth(w): width = w {
    if (width == 0) {
      throw "0 width not allowed!";
    }
  }

  @override
  String getTitle() {
    return "Square";
  }

  @override
  double calculateArea() {
    return width * width;
  }

  @override
  double calculatePerimeter() {
    return 4 * width;
  }
}

// прямоугольник
class Rectangle extends Shape {
  double width;
  double height;

  // конструктор с именованными параметрами
  Rectangle({ required this.width, required this.height }) {
    if (width == 0) {
      throw "0 width not allowed!";
    }

    if (height == 0) {
      throw "0 height not allowed!";
    }
  }

  // Getter
  double get getWidth => width;
  double get getHeight => height;

  // Setter
  set setWidth(double w) => width = w;
  set setHeight(double h) => height = h;

  @override
  String getTitle() {
    return "Rectangle";
  }

  @override
  double calculateArea() {
    return width * height;
  }
}

// круг
class Circle extends Shape {
  final double radius;
  // статическое поле
  static double pi = math.pi;

  // статическая функция
  static double getPi() => pi;

  // конструктор с именованными параметрами
  Circle({ required this.radius }) {
    if (radius == 0) {
      throw "0 radius not allowed!";
    }
  }

  @override
  String getTitle() {
    return "Circle";
  }

  @override
  double calculateArea() {
    return Circle.pi * radius * radius;
  }
}

// 3D ФИГУРЫ
abstract class Shape3D with PrintDetailsMixin {
  double calculateVolume();

  // функции с различными типами параметров для Shape3D
  void printVolumeMsgXTimes(int x, String msg) {
    for(int i = 0; i < x; i++) {
      double volume = calculateVolume();
      print("Volume=");
      print(volume);
      print("custom message=");
      print(msg);
    }
  }
}

class Cube extends Shape3D {
  final double width;

  Cube({required this.width}) {
    if (width == 0) {
      throw "0 width not allowed!";
    }
  }

  @override
  double calculateVolume() {
    return width * width * width;
  }
}

class Sphere extends Shape3D {
  final double radius;

  Sphere({required this.radius}) {
    if (radius == 0) {
      throw "0 radius not allowed!";
    }
  }

  @override
  double calculateVolume() {
    return (4/3) * math.pi * radius * radius * radius;
  }
}

