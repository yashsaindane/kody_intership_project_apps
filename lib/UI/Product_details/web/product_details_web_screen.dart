import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Cart/web/cart_web_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/app_colors.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/cart/cart_provider.dart';
import 'package:shopping_web_app/framework/controller/product_detail/product_detail_provider.dart';
import 'package:shopping_web_app/framework/repository/cart/model/hive_cart_model.dart';

class ProductDetailWebScreen extends ConsumerStatefulWidget {
  const ProductDetailWebScreen({super.key});

  @override
  ConsumerState<ProductDetailWebScreen> createState() =>
      _ProductDetailWebScreenState();
}

class _ProductDetailWebScreenState
    extends ConsumerState<ProductDetailWebScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProduct = ref.watch(selectedProductProvider);
    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(title: Text(TextClass.productDetails)),
        body: Center(child: Text(TextClass.noProductSelected)),
      );
    }
    final images = selectedProduct.productList[0].imageUrl ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedProduct.productList[0].productName ?? '',
          style: TextStyle(color: AppColors.textColor, fontSize: 18),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final imageUrl = images[index];
                    return Flexible(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.broken_image, size: 50)),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              if (images.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: _currentPage == index ? 9 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.secondaryColor
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              SizedBox(height: 16),
              Text(
                'Price: ₹${selectedProduct.productList[0].productPrice ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                selectedProduct.productList[0].productDescription ?? '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  onPressed: () {
                    final cartProduct = CartProduct(
                      productId:
                          int.tryParse(
                            selectedProduct.productList[0].productId ?? '0',
                          ) ??
                          0,
                      productName:
                          selectedProduct.productList[0].productName ?? '',
                      productPrice:
                          selectedProduct.productList[0].productPrice ?? 0,
                      quantity: 1,
                      imageUrl: selectedProduct.productList[0].imageUrl ?? [],
                      dateTime: DateTime.now(),
                      status: ProductStatus.pending,
                      userEmail: '',
                    );
                    ref.read(cartProvider.notifier).addToCart(cartProduct);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(TextClass.productAddedToCart),
                        backgroundColor: AppColors.successColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartWebScreen()),
                    );
                  },
                  child: Text(
                    TextClass.addToCart,
                    style: TextStyle(color: AppColors.textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
