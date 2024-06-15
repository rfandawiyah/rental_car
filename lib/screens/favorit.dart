import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental_car/controller/favorit_controller.dart';

class FavoritPage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
      ),
      body: Obx(() {
        if (favoriteController.favoriteProducts.isEmpty) {
          return const Center(
            child: Text('Tidak ada mobil favorit.'),
          );
        }
        return ListView.builder(
          itemCount: favoriteController.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteController.favoriteProducts[index];
            return ListTile(
              title: Text(product.merkmobil),
              subtitle: Text(product.deskripsi),
              leading: Image.network(product.gambar,
                  fit: BoxFit.cover, width: 50, height: 50),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  favoriteController.removeProductFromFavorites(product);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
