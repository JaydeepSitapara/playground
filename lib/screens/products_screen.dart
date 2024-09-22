import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/produuct_model2.dart';
import 'package:playground/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  Future<List<Product>>? productFuture;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    refreshController.refreshCompleted();
  }

  void fetchData() {
    context.read<ProductsProvider>().incrementOffset();
    productFuture = context.read<ProductsProvider>().getProductList();
  }

  void _onLoading() async {
    fetchData();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Products'),
          ),
          body: FutureBuilder(
            future: productFuture,
            builder: (context, snapshot) {
              log('-----------------------------------------------------');
              log('length Productss: ${productProvider.productList.length}');
              log('-----------------------------------------------------');
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: refreshController,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                scrollController: scrollController,
                child: ListView.builder(
                  itemCount: productProvider.productList.length,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    final product = productProvider.productList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                          color: Colors.white70,
                          child: ListTile(
                            leading: CircleAvatar(
                              maxRadius: 24,
                              backgroundImage:
                                  NetworkImage(product.images?.last ?? ''),
                            ),
                            title: Text('Title : ${product.title ?? ''}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14)),
                            subtitle: Text(
                              'Category : ${product.category?.name}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          )),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
