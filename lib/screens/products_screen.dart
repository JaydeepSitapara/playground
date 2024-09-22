import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void fetchData() {
    if (context.read<ProductsProvider>().offSet <
        context.read<ProductsProvider>().maxOffset) {
      context.read<ProductsProvider>().getProductList();
      refreshController.loadComplete();
    } else {
      log('No more product founded');
      refreshController.loadNoData();
    }
  }

  void _onLoading() async {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
          ),
          body: SmartRefresher(
                      enablePullDown: false,
            enablePullUp: true,
            controller: refreshController,
            onLoading: _onLoading,
            scrollController: scrollController,
            footer: CustomFooter(
              builder: (BuildContext context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const CircularProgressIndicator();
                } else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator();
                } else {
                  body = const Text(
                    "No more products",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  );
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: ListView.builder(
              itemCount: productProvider.productList.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                final product = productProvider.productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
