/**
 * Создайте модель 'RandomUser' с помощью Null Safety,
 * которая будет представлять данные и будет содержать поля
 */
class RandomUser {
  final String gender;
  final String firstName;
  final String lastName;

  RandomUser({required this.gender, required this.firstName, required this.lastName});

  /**
   * Распарсите полученные данные JSON из API в объект,
   * используя конструктор модели.
   */
  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'gender': String gender,
        'name': Map<String, String> name
      } =>
        RandomUser(gender: gender,
          firstName: name['first'] ?? "<Имя>",
          lastName: name['last'] ?? "<Фамилия>"),
      _ => throw const FormatException('Ошибка парсинга RandomUser'),
    };
  }
}
