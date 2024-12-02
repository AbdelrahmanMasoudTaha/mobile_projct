class Product {
  final String name;
  final String descreption;
  final String imageLink;
  final Cateogry cateogry;
  final double price;
  double rate = 0;
  int numOfRatings = 0;
  int soldTimes = 0;

  Product(
      {required this.name,
      required this.descreption,
      required this.price,
      required this.imageLink,
      required this.cateogry});
  void rateTheProduct(int rate) {
    double totalRate = this.rate * numOfRatings;
    numOfRatings++;

    this.rate = (rate + totalRate) / numOfRatings;
  }
}

enum Cateogry { electronics, clothes, furniture, books, toys, sports }

List<Product> dummyProducts = [
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
    name: "iphone 12",
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
  Product(
    name: "iphone 12",
    cateogry: Cateogry.electronics,
    price: 120,
    descreption:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    imageLink:
        "https://www.smartcellular.ae/media/catalog/product/cache/44967087533007dde7246873a72eba7b/t/r/tr_9_1.jpg",
  ),
];
