// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detective_pikachu/model/favorite_page_models.dart';

class _FavoritePageList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var favoritepage = context.watch<FavoritePageModel>();

    return ListView.builder(
        itemCount: favoritepage.items.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.local_mall ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              favoritepage.remove(favoritepage.items[index]);
            },
          ),
          title: Text(
            favoritepage.items[index].name,
          ),
          subtitle: Text(
            favoritepage.items[index].subtitle,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
    );
  }
}


class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( ' ')
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: _FavoritePageList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}