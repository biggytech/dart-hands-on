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
  void printDetails() {
    if (this is Square) {
      var square = this as Square;
      stdout.write("Width:");
      stdout.write(square.width);
      print('');
      stdout.write("Area:");
      stdout.write(square.calculateArea());
      print('');
      stdout.write("Perimeter:");
      stdout.write(square.calculatePerimeter());
    } else if (this is Rectangle) {
      var rectangle = this as Rectangle;
      stdout.write("Width:");
      stdout.write(rectangle.getWidth);
      print('');
      stdout.write("Height:");
      stdout.write(rectangle.getHeight);
      print('');
      stdout.write("Area:");
      stdout.write(rectangle.calculateArea());
    } else if (this is Circle) {
      var circle = this as Circle;
      stdout.write("Radius:");
      stdout.write(circle.radius);
      print('');
      stdout.write("Area:");
      stdout.write(circle.calculateArea());
    } else if (this is Cube) {
      var cube = this as Cube;
      stdout.write("Width:");
      stdout.write(cube.width);
      print('');
      stdout.write("Volume:");
      stdout.write(cube.calculateVolume());
    } else if (this is Sphere) {
      var sphere = this as Sphere;
      stdout.write("Radius:");
      stdout.write(sphere.radius);
      print('');
      stdout.write("Volume:");
      stdout.write(sphere.calculateVolume());
    }

    print('');
  }
}

// 2D ФИГУРЫ
abstract class Shape {
  // нет тела метода - значит абстрактный
  double calculateArea();

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
class Square extends Shape with PrintDetailsMixin implements PerimeterCalculation {
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
  double calculateArea() {
    return width * width;
  }

  @override
  double calculatePerimeter() {
    return 4 * width;
  }
}

// прямоугольник
class Rectangle extends Shape with PrintDetailsMixin {
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
  double calculateArea() {
    return width * height;
  }
}

// круг
class Circle extends Shape with PrintDetailsMixin {
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
  double calculateArea() {
    return Circle.pi * radius * radius;
  }
}

// 3D ФИГУРЫ
abstract class Shape3D {
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

class Cube extends Shape3D with PrintDetailsMixin {
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

class Sphere extends Shape3D with PrintDetailsMixin {
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

