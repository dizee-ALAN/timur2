import 'dart:io';

class Book {
  String title;
  String author;
  int year;
  bool isAvailable;

  Book(this.title, this.author, this.year, {this.isAvailable = true});

  void showInfo() {
    String status = isAvailable ? 'доступна' : 'выдана';
    print('$title — $author ($year), $status');
  }
}

Book? findBook(List<Book> books, String title) {
  String target = title.toLowerCase();
  for (var book in books) {
    if (book.title.toLowerCase() == target) {
      return book;
    }
  }
  return null;
}

String readLine() {
  String? line = stdin.readLineSync();
  if (line == null) {
    return '';
  }
  return line.trim();
}

void main() {

  List<Book> books = [
    Book('1984', 'Оруэлл', 1949),
    Book('Дюна', 'Герберт', 1965),
    Book('451 по Фаренгейту', 'Брэдбери', 1953),
    Book('Хоббит', 'Толкин', 1937),
    Book('Чистый код', 'Мартин', 2008),
  ];

  while (true) {
   
    print('\n===== БИБЛИОТЕКА =====');
    print('1. Показать все книги');
    print('2. Найти книгу');
    print('3. Выдать книгу');
    print('4. Вернуть книгу');
    print('5. Добавить книгу');
    print('6. Выход');
    print('=====================');
    print('Выберите действие:');

    String answer = readLine();
    int? choice = int.tryParse(answer);

    if (choice == null) {
      print('Ошибка: введите число');
      continue;
    }

    if (choice == 1) {
      for (var book in books) {
        book.showInfo();
      }
    } else if (choice == 2) {
      print('Введите название книги:');
      String name = readLine();
      Book? book = findBook(books, name);
      if (book == null) {
        print('Книга не найдена');
      } else {
        book.showInfo();
      }
    } else if (choice == 3) {
      print('Введите название книги для выдачи:');
      String name = readLine();
      Book? book = findBook(books, name);
      if (book == null) {
        print('Книга не найдена');
      } else if (!book.isAvailable) {
        print('Книга уже выдана');
      } else {
        book.isAvailable = false;
        print('Книга выдана');
      }
    } else if (choice == 4) {
      print('Введите название книги для возврата:');
      String name = readLine();
      Book? book = findBook(books, name);
      if (book == null) {
        print('Книга не найдена');
      } else if (book.isAvailable) {
        print('Книга уже в библиотеке');
      } else {
        book.isAvailable = true;
        print('Книга возвращена');
      }
    } else if (choice == 5) {
      print('Введите название:');
      String title = readLine();
      print('Введите автора:');
      String author = readLine();
      print('Введите год выпуска:');
      int? year = int.tryParse(readLine());

      if (title.isEmpty || author.isEmpty || year == null || year <= 0) {
        print('Неверные данные книги');
      } else {
        books.add(Book(title, author, year));
        print('Книга добавлена');
      }
    } else if (choice == 6) {
      print('Выход');
      break;
    } else {
      print('Нет такого пункта меню');
    }
  }
}
