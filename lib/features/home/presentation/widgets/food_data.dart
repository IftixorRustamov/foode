class Food {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;

  const Food({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

final List<Food> foodList = [
  Food(imagePath: 'assets/images/freshsalad.png', title: 'Fresh Salad', subtitle: 'Cloudy Resto', price: '10'),
  Food(imagePath: 'assets/images/icecream.png', title: 'Yummie Ice Cream', subtitle: 'Circlo Resto', price: '6'),
  Food(imagePath: 'assets/images/vegan.png', title: 'Vegan Special', subtitle: 'Haty Food', price: '11'),
  Food(imagePath: 'assets/images/salad.png', title: 'Original Salad', subtitle: 'Lovy Food', price: '8'),
  Food(imagePath: 'assets/images/pasta.png', title: 'Mixed Pasta', subtitle: 'Circlo Resto', price: '13'),
  Food(imagePath: 'assets/images/icecream.png', title: 'Yummie Ice Cream', subtitle: 'Circlo Resto', price: '9'),
  Food(imagePath: 'assets/images/freshsalad.png', title: 'Fresh Salad', subtitle: 'Cloudy Resto', price: '10'),


];
