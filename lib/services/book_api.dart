import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "10.10.10.116:8000";

class BookApi {
  static Future getBooks() {
    final url = Uri.http(baseUrl, "/books");
    return http.get(url);
  }

  static Future createBook(String title, String author, String description) {
    final url = Uri.http(baseUrl, "/books");
    return http.post(url,
        body: {'title': title, 'author': author, 'description': description});
  }

  static Future updateBook(
      int id, String title, String author, String description) {
    final url = Uri.http(baseUrl, "/books/${id}");
    return http.put(url,
        body: {'title': title, 'author': author, 'description': description});
  }

  static Future deleteBook(int id) {
    final url = Uri.http(baseUrl, "/books/${id}");
    return http.delete(url);
  }
}
