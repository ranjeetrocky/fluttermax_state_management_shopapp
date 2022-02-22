import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttermax_state_management_shopapp/providers/cart.dart' as ci;
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final ci.CartItem cartItem;
  final String productId;
  const CartItem({
    Key? key,
    required this.cartItem,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final cart = Provider.of
    return Card(
      child: Dismissible(
        key: ValueKey(cartItem.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<ci.Cart>(context, listen: false).removeItem(productId);
        },
        dragStartBehavior: DragStartBehavior.down,
        background: Container(
          color: colorScheme.errorContainer,
          child: Icon(
            Icons.delete_outline_rounded,
            color: colorScheme.error,
          ),
        ),
        child: ListTile(
          title: Text(
            cartItem.title,
          ),
          trailing: Text(
            'Total: \$ ${cartItem.price * cartItem.quantity}',
          ),
          subtitle: Text('${cartItem.quantity} x ${cartItem.price}'),
        ),
      ),
    );
  }
}
