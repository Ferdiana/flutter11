import 'package:flutter1/models/book.dart';
import 'package:flutter1/screen/book_detail.dart';
import 'package:flutter1/services/book_api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'create_book.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var books = <Book>[];

  _getData() {
    BookApi.getBooks().then((res) {
      setState(() {
        Iterable list = json.decode(res.body)['data'];

        books = list.map((e) => Book.fromJson(e)).toList();
      });
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            String truncatedTitle = _truncateText(books[index].title);
            String truncatedAuthor = _truncateText(books[index].author);
            String truncatedDescription = _truncateText(books[index].description);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(book: books[index]),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  "Judul: $truncatedTitle",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Author: $truncatedAuthor"),
                    Text("Description: $truncatedDescription"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        BookApi.deleteBook(books[index].id);
                        setState(() {
                          _getData();
                        });
                      },
                      child: const Text(
                        "Hapus",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                          "/update-data",
                          arguments: [
                            books[index].id,
                            books[index].title,
                            books[index].author,
                            books[index].description,
                          ],
                        );
                      },
                      child: const Text("Edit"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateBook(),
            ),
          );
        },
        child: const Text("Tambah Data+"),
      ),
    );
  }

  String _truncateText(String text) {
    return text.length > 10 ? "${text.substring(0, 10)}..." : text;
  }
}
