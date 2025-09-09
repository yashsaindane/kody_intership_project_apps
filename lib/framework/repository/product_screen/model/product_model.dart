import 'package:flutter/material.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../../controller/product/products_provider.dart';

class ProductsList {
  final String? productId;
  final List<String>? imageUrl;
  final String productName;
  final double productPrice;
  final String? productDescription;
  final IconData? productTrailingIcon;
  final String? productInfo;
  final ProductCategory? category;
  final int quantity;
  final String? status;

  ProductsList({
    this.status,
    this.productInfo,
    this.quantity = 0,
    this.productTrailingIcon,
    required this.productId,
    this.productDescription,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'productName': productName,
    'imageUrl': imageUrl,
    'productPrice': productPrice,
    'quantity': quantity,
  };

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
    productName: json['productName'] ?? '',
    productPrice: double.tryParse(json['productPrice'].toString()) ?? 0,
    quantity: json['quantity'],
    productId: json['productId'],
    imageUrl: json['imageUrl'],
  );

  ProductsList copyWith({
    String? productName,
    double? productPrice,
    int? quantity,
    String? productId,
    List<String>? imageUrl,
  }) {
    return ProductsList(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

final List<ProductsList> productList = [
  ProductsList(
    imageUrl: [
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/735593be-d93f-4159-ba15-516a69d3f53f/NIKE+SB+PS8.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/45676317-5aec-400a-a798-e01b7c8237cc/NIKE+SB+PS8.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/4ea1b25d-84dc-4418-9c93-b82e856e3c60/NIKE+SB+PS8.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/3a599053-4e8e-47bd-824f-fa98cebe36b1/NIKE+SB+PS8.png',
    ],
    productName: TextClass.nike1Product,
    productPrice: 10795.00,
    quantity: 1,
    category: ProductCategory.shoes,
    productId: '101',
    productInfo:
        "Designed to put in the work out of the box, the PS8 delivers with a 3-pronged approach.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        'Designed to put in the work out of the box, the PS8 delivers with a 3-pronged approach. Starting with a layered Flyknit construction with leather in high-wear areas, it offers a broken-in feel that retains its shape session after session. An updated Flyplate is integrated into the sole, providing a responsive feel that works in tandem with the HART (High Abrasion Rubber Tech) outsole. HART uses less rubber to help make the outsole lighter and more flexible. The PS8 wraps it all in a low-top silhouette with Nike Running aesthetics, heritage pattern and all the technical details that matter.',
  ),
  ProductsList(
    imageUrl: [
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/5d4a6be3-1b4b-42c5-bf68-074c0c8bdaba/NIKE+SB+ZOOM+BLAZER+MID.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/7c778219-2004-45aa-b200-e2ddf876198a/NIKE+SB+ZOOM+BLAZER+MID.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/57dd2546-473b-4d18-bc8a-8fee3d5997b9/NIKE+SB+ZOOM+BLAZER+MID.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/8e3090f2-aa8e-4cc5-b1e6-d4854ab430d8/NIKE+SB+ZOOM+BLAZER+MID.png',
    ],
    productName: TextClass.nike2Product,
    productId: '102',
    productPrice: 8595.00,
    quantity: 1,
    category: ProductCategory.shoes,
    productInfo:
        "The Blazer Mid is an iconic hoops shoe tailored to the needs of the modern skateboarder.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "The Blazer Mid is an iconic hoops shoe tailored to the needs of the modern skateboarder. Durable leather is paired with tacky rubber for flexible grip and comfort that lasts.",
  ),
  ProductsList(
    imageUrl: [
      'https://static.nike.com/a/images/w_1280,q_auto,f_auto/739c6246-c745-425e-a393-a85e870d0ec9/air-foamposite-one-black-and-varsity-red-ib2219-001-release-date.jpg',
      'https://static.nike.com/a/images/w_1280,q_auto,f_auto/513eba27-3dc4-4444-a25a-2f519b80a7cc/air-foamposite-one-black-and-varsity-red-ib2219-001-release-date.jpg',
      'https://static.nike.com/a/images/w_1280,q_auto,f_auto/8a31dd49-e255-4342-a38f-c7e8da6bddf5/air-foamposite-one-black-and-varsity-red-ib2219-001-release-date.jpg',
      'https://static.nike.com/a/images/w_1280,q_auto,f_auto/c444547e-7431-4f02-acb2-3c4e24d2da05/air-foamposite-one-black-and-varsity-red-ib2219-001-release-date.jpg',
    ],
    productName: TextClass.nike3Product,
    productPrice: 20495.00,
    productId: '103',
    quantity: 1,
    category: ProductCategory.shoes,
    productInfo: "Step into the history books with the Air Foamposite One.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "Step into the history books with the Air Foamposite One. Rare, classic and ahead of its time, it's a testament to Penny Hardaway's unforgettable game—and one of the boldest looks to move off-court. The striking Black and Varsity Red colorway brings the juice, while the upper's iconic liquid design boosts the cool factor. The finishing touch? Penny's signature 1 Cent",
  ),
  ProductsList(
    imageUrl: [
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/c000386a-dc24-4a07-bcb7-23e293cfbb4d/AIR+JORDAN+4+RETRO.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/4e0be7bf-0728-42b2-8385-cb8ca54a01d9/AIR+JORDAN+4+RETRO.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/91ed6fc8-7f98-4604-a4bb-66b853df5284/AIR+JORDAN+4+RETRO.png',
      'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/e711920b-820b-4aed-992c-dc1c82a73a0e/AIR+JORDAN+4+RETRO.png',
    ],
    productName: TextClass.nike4Product,
    productPrice: 19495.00,
    productId: '104',
    category: ProductCategory.shoes,
    quantity: 1,
    productInfo:
        "Step into a classic. This AJ4 throws it back with full-grain leather and premium textiles.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "Step into a classic. This AJ4 throws it back with full-grain leather and premium textiles. Iconic design elements from the original, like floating eyestays and mesh-inspired accents, feel just as fresh as they did in '89.",
  ),
  ProductsList(
    imageUrl: [
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/dcd5f60d5daa42f99790af3400bb5f2d_9366/adidas_by_Stella_McCartney_Sportswear_Shoe_Black_HP3213_01_standard.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/19edd64deabf462089f6af3400bb7b2c_9366/adidas_by_Stella_McCartney_Sportswear_Shoe_Black_HP3213_02_standard_hover.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/19edd64deabf462089f6af3400bb7b2c_9366/adidas_by_Stella_McCartney_Sportswear_Shoe_Black_HP3213_02_standard_hover.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/0ed485d28f07437c8913af810110091b_9366/adidas_by_Stella_McCartney_Sportswear_Shoe_Black_HP3213_HM4.jpg',
    ],
    productName: TextClass.adidas1Product,
    productPrice: 32999.00,
    productId: '105',
    category: ProductCategory.shoes,
    quantity: 1,
    productInfo:
        "Futuristic and functional, you'll be a step closer to a better planet in the adidas by Stella McCartney Sportswear Shoe.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "Futuristic and functional, you'll be a step closer to a better planet in the adidas by Stella McCartney Sportswear Shoe. Inspired by nature, the shoe is crafted in part from natural and renewable materials. A sock-like upper is set atop a cool, chunky midsole for ultimate comfort and support with every step. Pared-back hues and a fashion-forward silhouette means you can easily incorporate them into your everyday wardrobe, too.",
  ),
  ProductsList(
    imageUrl: [
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/affb4020eddb4ebeaacec581a17fe650_9366/ULTRABOOST_1.0_SHOES_Black_JH6583_04_standard.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/0ed485d28f07437c8913af810110091b_9366/adidas_by_Stella_McCartney_Sportswear_Shoe_Black_HP3213_HM4.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/affb4020eddb4ebeaacec581a17fe650_9366/ULTRABOOST_1.0_SHOES_Black_JH6583_04_standard.jpg',
      'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/0104e77d7b7f47438f4afbfa712fa2b9_9366/ULTRABOOST_1.0_SHOES_Black_JH6583_42_detail.jpg',
    ],
    productName: TextClass.adidas2Product,
    productPrice: 17999.00,
    category: ProductCategory.shoes,
    productId: '106',
    quantity: 1,
    productInfo:
        "From a walk in the park to a weekend run with friends, these adidas Ultraboost 1.0 shoes are designed to keep you comfortable.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "From a walk in the park to a weekend run with friends, these adidas Ultraboost 1.0 shoes are designed to keep you comfortable. An adidas PRIMEKNIT upper gently hugs your feet while BOOST on the midsole cushions from the first step to the last mile. The Stretchweb outsole flexes naturally for an energised ride, and Continental™ Rubber gives you the traction you need to keep that pep in your step.",
  ),
  ProductsList(
    imageUrl: [
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/marshall-woburn-iii-speaker-black_1_1676563109.jpg',
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/marshall-woburn-iii-speaker-black_3_1676563109.jpg',
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/marshall-woburn-iii-speaker-black_3_1676563109.jpg',
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/marshall-woburn-iii-speaker-black_4_1676563109.jpg',
    ],
    productName: TextClass.speaker1Product,
    productPrice: 52999,
    category: ProductCategory.speakers,
    productId: '107',
    quantity: 1,
    productInfo:
        "HOME-SHAKING SOUND: Woburn III has an even wider soundstage than its predecessor and fills any space with immersive.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "HOME-SHAKING SOUND: Woburn III has an even wider soundstage than its predecessor and fills any space with immersive, home-shaking Marshall signature sound. Woburn III has been re-engineered with a new three-way driver system, which delivers more controlled, lower-frequency bass and greater clarity in the midrange.",
  ),
  ProductsList(
    imageUrl: [
      'https://m.media-amazon.com/images/I/7192Qca-fUL._SL1500_.jpg',
      'https://m.media-amazon.com/images/I/7192Qca-fUL._SL1500_.jpg',
      'https://m.media-amazon.com/images/I/71G0F3RKmfL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/71G0F3RKmfL._AC_SL1500_.jpg',
    ],
    productName: TextClass.speaker2Product,
    productPrice: 14389,
    category: ProductCategory.speakers,
    productId: '108',
    quantity: 1,
    productInfo:
        "MUSIC CALLS: The Bose SoundLink Flex Portable Bluetooth Speaker (2nd Gen) packs big.",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "MUSIC CALLS: The Bose SoundLink Flex Portable Bluetooth Speaker (2nd Gen) packs big, bold sound in a packable size that’s perfect for sharing tunes and good times anywhere on the planet SOUND THAT TAKES YOU PLACES: Take advantage of the surprisingly powerful performance of this Bose portable speaker with its clear, balanced, high-fidelity audio and deep bass that is easy to take with you",
  ),
  ProductsList(
    imageUrl: [
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/major-v-black-front-desktop-1_1.jpg',
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/1/-/1-major-v-brown-front-desktop_1.jpg',
      'https://www.myimaginestore.com/media/catalog/Product/cache/0469a4dc62dd6e534a19177e6b269c6b/m/a/major-v-black-side-desktop-3_1.jpg',
    ],
    productName: TextClass.headphone1Product,
    productId: '109',
    category: ProductCategory.headphones,
    productInfo:
        "MARSHALL SIGNATURE SOUND. Thunderous bass, smooth mids and crisp treble.",
    productPrice: 14999,
    quantity: 1,
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "MARSHALL SIGNATURE SOUND. Thunderous bass, smooth mids and crisp treble. Major V delivers the Marshall signature sound you know and love.100+ HOURS OF WIRELESS PLAYTIME. Your next adventure awaits, and Major V is in for the ride. Packing 100+ hours of wireless playtime, you can be gone for days. RUGGED AND FOLDABLE DESIGN. Rugged so that it lasts. Foldable for compact storage. Major is an instant classic for the fifth time running.",
  ),

  ProductsList(
    imageUrl: [
      'https://m.media-amazon.com/images/I/51chGVeddYL._SL1200_.jpg',
      'https://m.media-amazon.com/images/I/71G0F3RKmfL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/71G0F3RKmfL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/61H+hTjnu7L._AC_SL1284_.jpg',
    ],
    productName: TextClass.headphone2Product,
    productPrice: 29989,
    category: ProductCategory.headphones,
    productId: '110',
    quantity: 1,
    productTrailingIcon: Icons.shopping_cart_outlined,
    productInfo:
        "LEVELED-UP LISTENING: Bose QuietComfort Ultra Headphones with spatial audio give you an immersive experience.",
    productDescription:
        "LEVELED-UP LISTENING: Bose QuietComfort Ultra Headphones with spatial audio give you an immersive experience that makes music feel more real; CustomTune technology offeres personalized sound, shaped to you WORLD-CLASS NOISE CANCELLATION: These noise cancelling headphones feature Quiet Mode, Aware Mode and Immersion Mode, which combines full noise cancellation and Bose Immersive Audio",
  ),
  ProductsList(
    imageUrl: [
      'https://m.media-amazon.com/images/I/71zuMSjwDfL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/718pKzoKszL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/718pKzoKszL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/718pKzoKszL._AC_SL1500_.jpg',
      'https://m.media-amazon.com/images/I/81+u9RUkhmL._AC_SL1500_.jpg',
    ],
    productName: TextClass.laptop1Product,
    productPrice: 46990,
    category: ProductCategory.laptops,
    productId: '111',
    quantity: 1,
    productInfo:
        "Processor: AMD Ryzen 7 6800H Mobile Processor (8-core/16-thread, 20MB cache, up to 4.7 GHz max boost).",
    productTrailingIcon: Icons.shopping_cart_outlined,
    productDescription:
        "Processor: AMD Ryzen 7 6800H Mobile Processor (8-core/16-thread, 20MB cache, up to 4.7 GHz max boost) Play over 100 high-quality PC games, plus new and upcoming blockbusters on day one like Halo Infinite, Forza Horizon 5, and Age of Empires IV with your new G513RC-HN083W and one month of Game Pass-including EA Play.",
  ),
];
