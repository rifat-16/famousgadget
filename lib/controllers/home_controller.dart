import 'package:get/get.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> bestSellers = <ProductModel>[].obs;
  final RxList<ProductModel> hotDeals = <ProductModel>[].obs;
  final RxInt activeBannerIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    categories.assignAll([
      const CategoryModel(
        id: '1',
        name: 'Smart Watch',
        icon: 'watch',
        itemCount: 86,
      ),
      const CategoryModel(
        id: '2',
        name: 'Camera',
        icon: 'camera',
        itemCount: 45,
      ),
      const CategoryModel(
        id: '3',
        name: 'Gimbal',
        icon: 'videocam',
        itemCount: 32,
      ),
      const CategoryModel(
        id: '4',
        name: 'Accessories',
        icon: 'headphones',
        itemCount: 120,
      ),
      const CategoryModel(
        id: '5',
        name: 'Projector',
        icon: 'videocam',
        itemCount: 28,
      ),
      const CategoryModel(
        id: '6',
        name: 'Microphone',
        icon: 'mic',
        itemCount: 39,
      ),
      const CategoryModel(
        id: '7',
        name: 'Router',
        icon: 'router',
        itemCount: 54,
      ),
      const CategoryModel(
        id: '8',
        name: 'Tablet',
        icon: 'tablet_mac',
        itemCount: 42,
      ),
    ]);

    featuredProducts.assignAll([
      const ProductModel(
        id: 'p1',
        title: 'Apple Watch Ultra 2',
        description:
            'The most rugged and capable Apple Watch. Designed for outdoor adventure and endurance athletes with 49mm titanium case and up to 36 hours battery life.',
        imageUrl:
            'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500&auto=format&fit=crop&q=80',
        price: 89990.0,
        oldPrice: 99990.0,
        rating: 4.9,
        reviewCount: 128,
        category: 'Smart Watch',
        savePercentage: 10,
        colors: ['Titanium Orange', 'Natural Titanium', 'Dark Slate'],
        specifications: {
          'Battery': 'Up to 36 Hours',
          'Display': '3000 nits Always-On Retina',
          'Water Resistance': '100m water resistant',
          'Case Size': '49mm Titanium',
        },
      ),
      const ProductModel(
        id: 'p2',
        title: 'DJI Osmo Mobile 6',
        description:
            'Intelligent smartphone stabilizer with 3-axis stabilization, built-in extension rod, portable and foldable design, and ActiveTrack 6.0.',
        imageUrl:
            'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=500&auto=format&fit=crop&q=80',
        price: 16500.0,
        oldPrice: 19500.0,
        rating: 4.8,
        reviewCount: 94,
        category: 'Gimbal',
        savePercentage: 15,
        colors: ['Slate Grey', 'Platinum White'],
        specifications: {
          'Battery Life': 'Approx. 6.5 Hours',
          'Weight': '309g',
          'Connectivity': 'Bluetooth 5.1',
          'Tracking': 'ActiveTrack 6.0',
        },
      ),
      const ProductModel(
        id: 'p3',
        title: 'Sony WF-1000XM5',
        description:
            'Industry-leading noise cancelling with two proprietary processors and dual feedback microphones. Exceptional sound quality with High-Resolution Audio.',
        imageUrl:
            'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop&q=80',
        price: 32500.0,
        oldPrice: 45000.0,
        rating: 4.8,
        reviewCount: 142,
        category: 'Accessories',
        savePercentage: 27,
        colors: ['Navy Blue', 'Carbon Black', 'Platinum Silver'],
        specifications: {
          'Battery Life': 'Up to 30 Hours',
          'Noise Cancelling': 'Industry Leading ANC',
          'Driver Size': '30mm',
          'Connectivity': 'Bluetooth 5.2',
          'Weight': '250g',
          'Codec Support': 'LDAC / AAC / SBC',
          'Microphone': 'Beamforming (4 mics)',
          'Water Resistance': 'IPX4',
        },
      ),
    ]);

    bestSellers.assignAll([
      const ProductModel(
        id: 'p4',
        title: 'Ring Video Doorbell Cam',
        description:
            '1080p HD video doorbell with enhanced features that let you see, hear, and speak to anyone from your phone, tablet, or PC.',
        imageUrl:
            'https://images.unsplash.com/photo-1558002038-1055907df827?w=500&auto=format&fit=crop&q=80',
        price: 18900.0,
        oldPrice: 22500.0,
        rating: 4.8,
        reviewCount: 312,
        category: 'Camera',
        savePercentage: 16,
        colors: ['Satin Nickel', 'Venetian Bronze'],
        specifications: {
          'Video': '1080p HD, Live View, Night Vision',
          'Connectivity': '802.11 b/g/n Wi-Fi @ 2.4 GHz',
          'Power': 'Built-in rechargeable battery',
        },
      ),
      const ProductModel(
        id: 'p5',
        title: 'iPad Air M2 (11-inch)',
        description:
            'Redesigned 11-inch iPad Air with stunning Liquid Retina display and the blazing-fast Apple M2 chip. Supports Apple Pencil Pro.',
        imageUrl:
            'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500&auto=format&fit=crop&q=80',
        price: 78500.0,
        oldPrice: 86000.0,
        rating: 4.9,
        reviewCount: 450,
        category: 'Tablet',
        savePercentage: 9,
        colors: ['Space Gray', 'Blue', 'Purple', 'Starlight'],
        specifications: {
          'Processor': 'Apple M2 Chip with 8-core CPU',
          'Storage': '128GB / 256GB / 512GB',
          'Display': '11-inch Liquid Retina Display',
        },
      ),
      const ProductModel(
        id: 'p6',
        title: 'Blue Yeti USB Microphone',
        description:
            'Professional multi-pattern USB mic for recording and streaming. Custom three-capsule array for clear, powerful broadcast-quality sound.',
        imageUrl:
            'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=500&auto=format&fit=crop&q=80',
        price: 14500.0,
        oldPrice: 17500.0,
        rating: 4.6,
        reviewCount: 180,
        category: 'Microphone',
        savePercentage: 17,
        colors: ['Blackout', 'Silver', 'Midnight Blue'],
        specifications: {
          'Capsules': '3 Blue-proprietary 14mm condenser',
          'Polar Patterns': 'Cardioid, Bidirectional, Omnidirectional',
          'Frequency Response': '20Hz - 20kHz',
        },
      ),
    ]);

    hotDeals.assignAll([
      const ProductModel(
        id: 'p7',
        title: 'Anker Soundcore R50i',
        description:
            'True wireless earbuds with 10mm drivers for heavy bass, 30 hours of playtime, IPX5 water resistance, and 2 mics for clear AI calls.',
        imageUrl:
            'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop&q=80',
        price: 1999.0,
        oldPrice: 2499.0,
        rating: 4.7,
        reviewCount: 520,
        category: 'Accessories',
        savePercentage: 20,
        colors: ['Black', 'White', 'Blue'],
        specifications: {
          'Playtime': '10H single charge, 30H with case',
          'Waterproof': 'IPX5',
          'Driver': '10mm BassBoost Driver',
        },
      ),
      const ProductModel(
        id: 'p8',
        title: 'OnePlus Nord CE 3 Lite',
        description:
            'Equipped with 108MP camera system, 67W SUPERVOOC fast charging, 5000mAh battery, and Qualcomm Snapdragon 695 5G.',
        imageUrl:
            'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&auto=format&fit=crop&q=80',
        price: 24499.0,
        oldPrice: 27999.0,
        rating: 4.8,
        reviewCount: 215,
        category: 'Smartphones',
        savePercentage: 12,
        colors: ['Pastel Lime', 'Chromatic Gray'],
        specifications: {
          'Camera': '108MP Main Camera + 2MP Depth',
          'Charging': '67W SUPERVOOC Endurance Edition',
          'Battery': '5000mAh Large Battery',
        },
      ),
      const ProductModel(
        id: 'p9',
        title: 'Anker 737 PowerBank 24K',
        description:
            'Equipped with Power Delivery 3.1 and bi-directional technology to quickly recharge the portable charger or get a 140W ultra-powerful charge.',
        imageUrl:
            'https://images.unsplash.com/photo-1609592424109-dd9892f1b177?w=500&auto=format&fit=crop&q=80',
        price: 11999.0,
        oldPrice: 14500.0,
        rating: 4.9,
        reviewCount: 244,
        category: 'Accessories',
        savePercentage: 17,
        colors: ['Black'],
        specifications: {
          'Capacity': '24,000mAh',
          'Max Output': '140W Two-Way Fast Charging',
          'Smart Display': 'Digital Smart Screen',
        },
      ),
      const ProductModel(
        id: 'p10',
        title: 'Xiaomi Wanbo T2 Max Projector',
        description:
            'Native 1080P Full HD mini projector, 450 ANSI Lumens, Android 9.0 TV system, dual-band Wi-Fi and Bluetooth 5.0.',
        imageUrl:
            'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=500&auto=format&fit=crop&q=80',
        price: 18500.0,
        oldPrice: 22000.0,
        rating: 4.6,
        reviewCount: 112,
        category: 'Projector',
        savePercentage: 16,
        colors: ['White', 'Midnight Blue'],
        specifications: {
          'Brightness': '450 ANSI Lumens',
          'Resolution': '1920 x 1080P Native',
          'Speakers': 'Dual 3W Hi-Fi Speakers',
        },
      ),
    ]);
  }
}
