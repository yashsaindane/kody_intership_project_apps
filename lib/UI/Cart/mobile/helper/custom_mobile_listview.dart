import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/auth_controller/auth/auth_provider.dart';
import '../../../../framework/controller/cart/cart_provider.dart';
import '../../../utils/theme/app_colors.dart';

class CustomMobileListview extends ConsumerStatefulWidget {
  const CustomMobileListview({super.key});

  @override
  ConsumerState<CustomMobileListview> createState() =>
      _CustomMobileListviewState();
}

class _CustomMobileListviewState extends ConsumerState<CustomMobileListview> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final authState = ref.watch(authProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final isGuest = authState == null || !authState.isLogin;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final product = cart[index];
        return Card(
          elevation: 6,
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(
              product.imageUrl.first ?? '',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            title: Text(
              product.productName ?? '',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹${product.productPrice}',
                  style: TextStyle(color: AppColors.textColor, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 20),
                          onPressed: () {
                            if (product.quantity > 1) {
                              cartNotifier.updateCart(
                                product,
                                product.quantity - 1,
                              );
                            } else {
                              cartNotifier.updateCart(product, 0);
                            }
                          },
                        ),
                        Text(
                          '${product.quantity}',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 20),
                          onPressed: () {
                            cartNotifier.updateCart(
                              product,
                              product.quantity + 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
