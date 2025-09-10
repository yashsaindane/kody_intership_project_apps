import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/product/products_provider.dart';
import 'package:shopping_web_app/framework/controller/product_detail/product_detail_provider.dart';
import 'package:shopping_web_app/ui/Cart/mobile/cart_mobile_screen.dart';
import 'package:shopping_web_app/ui/product_details/mobile/product_detail_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

class CustomMobileListView extends ConsumerStatefulWidget {
  const CustomMobileListView({super.key});

  @override
  ConsumerState<CustomMobileListView> createState() =>
      _CustomMobileListViewState();
}

class _CustomMobileListViewState extends ConsumerState<CustomMobileListView> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(sortListProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        TextClass.sortByCategory,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      ChoiceChip(
                        label: Text(TextClass.all),
                        selected: categoryFilter == null,
                        onSelected: (context) {
                          ref.read(categoryFilterProvider.notifier).state =
                              null;
                        },
                      ),
                      SizedBox(width: 8),
                      ...ProductCategory.values.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            backgroundColor: AppColors.secondaryColor,
                            label: Text(category.label),
                            selected: categoryFilter == category,
                            onSelected: (context) {
                              ref.read(categoryFilterProvider.notifier).state =
                                  category;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 6,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    product.imageUrl?.first ?? '',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    product.productName ?? '',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productInfo ?? 'error',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.textColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '`₹${product.productPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartMobileScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          product.productTrailingIcon,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.end,
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(Icons.remove, size: 13),
                      //       onPressed: () {
                      //         // if (product.quantity > 1) {
                      //         //   cartNotifier.updateCart(
                      //         //     product,
                      //         //     product.quantity - 1,
                      //         //   );
                      //         // } else {
                      //         //   cartNotifier.updateCart(product, 0);
                      //         // }
                      //       },
                      //     ),
                      //     Text(
                      //       '${product.quantity}',
                      //       style: TextStyle(fontSize: 12),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(Icons.add, size: 13),
                      //       onPressed: () {
                      //         // cartNotifier.updateCart(
                      //         //   product,
                      //         //   product.quantity + 1,
                      //         // );
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  onTap: () {
                    ref.read(selectedProductProvider.notifier).addPro(product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailMobileScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
