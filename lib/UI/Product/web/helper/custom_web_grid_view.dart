import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';

import '../../../../framework/controller/product/products_provider.dart';
import '../../../../framework/controller/product_detail/product_detail_provider.dart';
import '../../../Product_details/web/product_details_web_screen.dart';
import '../../../utils/theme/app_colors.dart';

class CustomWebGridView extends ConsumerStatefulWidget {
  const CustomWebGridView({super.key});

  @override
  ConsumerState<CustomWebGridView> createState() => _CustomWebGridViewState();
}

class _CustomWebGridViewState extends ConsumerState<CustomWebGridView> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(sortListProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      TextClass.sortByCategory,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ChoiceChip(
                      label: Text(TextClass.all),
                      selected: categoryFilter == null,
                      onSelected: (context) {
                        ref.read(categoryFilterProvider.notifier).state = null;
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
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              child: ListTile(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 6,
                      child: Image.network(
                        product.imageUrl?.first ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.productName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹${product.productPrice}',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        product.productInfo ?? 'error',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // trailing: InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => CartWebScreen()),
                //     );
                //   },
                //   child: Icon(
                //     product.productTrailingIcon,
                //     color: AppColors.secondaryColor,
                //   ),
                // ),
                onTap: () {
                  ref.read(selectedProductProvider.notifier).addPro(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailWebScreen(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
