class Restaurant {
  final String id;
  final String name;
  final String location;
  final String distance;
  final String price;
  final String cuisine;
  final String image;

  const Restaurant({this.id, this.name, this.location, this.distance, this.price,
    this.cuisine, this.image});
}

List<Restaurant> restaurants = [
  const Restaurant(
    id: "1",
    name: "La Taqueria",
    location: "west broadway",
    distance: "2104 m",
    price: "\$",
    cuisine: "Mexican",
    image: "assets/img/sample_img_0.png",
  ),
  const Restaurant(
    id: "2",
    name: "Stepho's",
    location: "west end",
    distance: "500 m",
    price: "\$",
    cuisine: "Mediterranean",
    image: "assets/img/sample_img_0.png",
  ),
  const Restaurant(
    id: "3",
    name: "L'Abattoir",
    location: "gastown",
    distance: "120 m",
    price: "\$\$\$",
    cuisine: "Fine Dining",
    image: "assets/img/sample_img_0.png",
  ),
  const Restaurant(
    id: "4",
    name: "Minami",
    location: "yaletown",
    distance: "700 m",
    price: "\$\$\$",
    cuisine: "Sushi",
    image: "assets/img/sample_img_0.png",
  ),
  const Restaurant(
    id: "5",
    name: "Meat & Bread",
    location: "gastown",
    distance: "342 m",
    price: "\$\$",
    cuisine: "Sandwhiches",
    image: "assets/img/sample_img_0.png",
  ),
];