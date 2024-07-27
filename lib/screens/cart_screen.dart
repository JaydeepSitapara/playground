import 'package:flutter/material.dart';
import 'package:playground/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: cart.items.isEmpty
                  ? const Center(
                      child: Text('No item found!'),
                    )
                  : ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart.items[index];
                        return ListTile(
                          title: Text(cartItem.name.toString()),
                        );
                      },
                    ),
        );
      },
    );
  }
}
