import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool showOnlyFavorites;
  const ProductsGridView({
    Key? key,
    required this.showOnlyFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = showOnlyFavorites
        ? productsProvider.favoriteItems
        : productsProvider.items;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: products[index], child: const ProductItem()),
      itemCount: products.length,
    );
  }
}