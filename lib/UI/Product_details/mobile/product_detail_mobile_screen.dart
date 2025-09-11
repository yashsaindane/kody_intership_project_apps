import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Product_details/mobile/helper/custom_modile_productdetail_elevated.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/product_detail/product_detail_provider.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

class ProductDetailMobileScreen extends ConsumerStatefulWidget {
  const ProductDetailMobileScreen({super.key});

  @override
  ConsumerState<ProductDetailMobileScreen> createState() =>
      _ProductDetailMobileScreenState();
}

class _ProductDetailMobileScreenState
    extends ConsumerState<ProductDetailMobileScreen> {
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
    final selectedProductList = ref.watch(selectedProductProvider).productList;
    final selectedProduct = selectedProductList.isNotEmpty
        ? selectedProductList.last
        : null;
    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(title: Text(TextClass.productDetails)),
        body: Center(child: Text(TextClass.noProductSelected)),
      );
    }
    final images = selectedProduct.imageUrl ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedProduct.productName ?? '',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final imageUrl = images[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                'Price: ₹${selectedProduct.productPrice ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                TextClass.description,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                selectedProduct.productDescription ?? '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: CustomModileProductdetailElevated(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
