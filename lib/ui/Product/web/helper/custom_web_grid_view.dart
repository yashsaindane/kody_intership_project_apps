import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/product_controller/product_provider.dart';
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
    final selectedSort = ref.watch(sortTypeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Text(
                "Sort by:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(width: 10),
              DropdownButton<ProductSortType>(
                dropdownColor: AppColors.backgroundColor,
                elevation: 6,
                borderRadius: BorderRadius.circular(20),

                value: selectedSort,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(sortTypeProvider.notifier).state = value;
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: ProductSortType.name,
                    child: Text("Name"),
                  ),
                  DropdownMenuItem(
                    value: ProductSortType.category,
                    child: Text("Category"),
                  ),
                  DropdownMenuItem(
                    value: ProductSortType.price,
                    child: Text("Price"),
                  ),
                ],
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
                    Image.network(
                      product.imageUrl?.first ?? '',
                      width: 340,
                      height: 155,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.productName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
                        product.productInfo ?? 'error',
                        style: TextStyle(color: AppColors.textColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '₹${product.productPrice?.toStringAsFixed(2) ?? 'error'}',
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
                  ref.read(selectedProductProvider.notifier).state = product;
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
