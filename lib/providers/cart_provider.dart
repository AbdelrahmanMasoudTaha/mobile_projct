import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/models/prodect.dart';

// StateNotifier to manage cart state
class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier()
      : super([
          Product(
            name: "iphone 12",
            price: 120,
            cateogry: Cateogry.electronics,
            descreption:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            imageLink:
                "https://www.smartcellular.ae/media/catalog/product/cache/44967087533007dde7246873a72eba7b/t/r/tr_9_1.jpg",
          ),
          Product(
            name: "labtop",
            cateogry: Cateogry.electronics,
            price: 120,
            descreption:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            imageLink:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKrYe0AQcXQzKYZ4oovVv8Lutl33o7ZM4HBQ&s",
          ),
          Product(
            name: "iphone 12",
            cateogry: Cateogry.electronics,
            price: 120,
            descreption:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            imageLink:
                "https://www.smartcellular.ae/media/catalog/product/cache/44967087533007dde7246873a72eba7b/t/r/tr_9_1.jpg",
          ),
          Product(
            name: "iphone 12",
            cateogry: Cateogry.electronics,
            price: 120,
            descreption:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            imageLink:
                "https://www.smartcellular.ae/media/catalog/product/cache/44967087533007dde7246873a72eba7b/t/r/tr_9_1.jpg",
          ),
        ]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(Product product) {
    state = state.where((p) => p != product).toList();
  }
}

// Provider for the cart
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});
