import 'package:flutter/material.dart';
import './utils/theme.dart';

class NamedRoutesWithParams extends StatelessWidget {
  const NamedRoutesWithParams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes With Params'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=904&hei=840&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1587460552755',
              width: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Подробнее'),
              onPressed: () {
                Product product = Product(
                  imageUrl:
                      'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=904&hei=840&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1587460552755',
                  name: 'Macbook Pro 13, 2020',
                  description:
                      'Intel Core i5, Turbo Boost up to 3.8GHz, 32GB, 1TB SSD',
                );
                Navigator.pushNamed(context, '/details', arguments: product);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
  });
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Product product = args as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробная информация'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(
                    product.imageUrl,
                    width: 300,
                  ),
                  ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Назад'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}