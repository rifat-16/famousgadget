import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class MockDatabase {
  MockDatabase._();

  // ==========================================
  // CATEGORIES
  // ==========================================
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Smart Watch',
      icon: 'watch',
      itemCount: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '2',
      name: 'Camera',
      icon: 'camera',
      itemCount: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '3',
      name: 'Gimbal',
      icon: 'videocam',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1615986201152-7686a4867f30?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '4',
      name: 'Accessories',
      icon: 'headphones',
      itemCount: 4,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '5',
      name: 'Projector',
      icon: 'videocam',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '6',
      name: 'Microphone',
      icon: 'mic',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1590602847861-f357a9332bbc?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '7',
      name: 'Router',
      icon: 'router',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1606904825846-647eb07f5be2?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '8',
      name: 'Tablet',
      icon: 'tablet_mac',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=200&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: '9',
      name: 'Smartphones',
      icon: 'phone_android',
      itemCount: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=200&auto=format&fit=crop&q=80',
    ),
  ];

  // ==========================================
  // ALL PRODUCTS (WITH 3-4 IMAGES PER PRODUCT)
  // ==========================================
  static const List<ProductModel> products = [
    // ----------------------------------------
    // 1. SMART WATCHES
    // ----------------------------------------
    ProductModel(
      id: 'sw_1',
      title: 'Apple Watch Ultra 2 (49mm Titanium)',
      description:
          'The ultimate sports and adventure watch. Features a lightweight aerospace-grade titanium case, precision dual-frequency GPS, up to 36 hours of battery life, and a 3000-nit Always-On Retina display.',
      imageUrl:
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1510017803434-a899398421b3?w=800&auto=format&fit=crop&q=80',
      ],
      price: 89990.0,
      oldPrice: 99990.0,
      rating: 4.9,
      reviewCount: 342,
      category: 'Smart Watch',
      savePercentage: 10,
      colors: ['Titanium Orange', 'Natural Titanium', 'Dark Ocean'],
      specifications: {
        'Display': '1.92-inch OLED Always-On, 3000 nits',
        'Case Material': 'Aerospace Grade 49mm Titanium',
        'Water Resistance': '100m water resistant / 40m dive rated',
        'Battery Life': 'Up to 36 hours (72 hours Low Power)',
        'Sensors': 'ECG, Blood Oxygen, Depth Gauge, Dual GPS',
      },
    ),
    ProductModel(
      id: 'sw_2',
      title: 'Samsung Galaxy Watch 6 Classic (47mm)',
      description:
          'Classic timeless design with a rotating physical bezel. Advanced sleep coaching, continuous ECG/BP monitoring, personalized heart rate zones, and Sapphire Crystal glass.',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&auto=format&fit=crop&q=80',
      ],
      price: 34500.0,
      oldPrice: 39900.0,
      rating: 4.8,
      reviewCount: 198,
      category: 'Smart Watch',
      savePercentage: 14,
      colors: ['Black', 'Silver'],
      specifications: {
        'Display': '1.5-inch Super AMOLED 480x480 Sapphire',
        'Bezel': 'Rotating Mechanical Bezel',
        'OS': 'Wear OS Powered by Samsung (One UI Watch 5)',
        'Battery': '425mAh (Up to 40 hours with AOD off)',
        'Durability': 'MIL-STD-810H & 5ATM + IP68',
      },
    ),
    ProductModel(
      id: 'sw_3',
      title: 'Amazfit Balance Smartwatch',
      description:
          'Mind & Body wellness smartwatch with Zepp Pay NFC contactless payments, dual-band circular GPS, body composition measurement, and ultra-long 14-day battery life.',
      imageUrl:
          'https://images.unsplash.com/photo-1517502884422-41eaead166d4?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1517502884422-41eaead166d4?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1544117519-31a4b719223d?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1508057198894-247b23fe5ade?w=800&auto=format&fit=crop&q=80',
      ],
      price: 21990.0,
      oldPrice: 24500.0,
      rating: 4.7,
      reviewCount: 115,
      category: 'Smart Watch',
      savePercentage: 10,
      colors: ['Midnight Black', 'Sunset Grey'],
      specifications: {
        'Display': '1.5-inch HD AMOLED 1500 nits',
        'Battery': 'Up to 14 days normal usage',
        'Health': 'Body Composition (BIA), Heart Rate, SpO2',
        'Connectivity': 'Bluetooth 5.0, Wi-Fi 2.4GHz, NFC',
      },
    ),

    // ----------------------------------------
    // 2. CAMERAS
    // ----------------------------------------
    ProductModel(
      id: 'cam_1',
      title: 'Sony Alpha A7 IV Full-Frame Mirrorless',
      description:
          'Groundbreaking hybrid camera featuring a newly developed 33MP Exmor R CMOS sensor, 4K 60p 10-bit 4:2:2 video, real-time Eye AF for humans, animals, and birds, plus 5.5-stop 5-axis IBIS.',
      imageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1512790182412-b19e6d62bc39?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1581591524425-c7e0978865fc?w=800&auto=format&fit=crop&q=80',
      ],
      price: 245000.0,
      oldPrice: 265000.0,
      rating: 4.9,
      reviewCount: 289,
      category: 'Camera',
      savePercentage: 8,
      colors: ['Black'],
      specifications: {
        'Sensor': '33MP Full-Frame Exmor R BSI CMOS',
        'Video Recording': '4K 60p in 10-Bit, S-Cinetone, S-Log3',
        'Autofocus': '759-Point Phase Detection AF with AI',
        'Stabilization': '5-Axis In-Body Image Stabilization (5.5 stops)',
        'Storage': 'Dual slots (CFexpress Type A & SD UHS-II)',
      },
    ),
    ProductModel(
      id: 'cam_2',
      title: 'Fujifilm X-T5 Mirrorless Camera',
      description:
          'Classic dial-driven retro design packed with modern power: 40.2MP X-Trans CMOS 5 HR sensor, 6.2K 30p internal video, 7-stop 5-axis IBIS, and signature Film Simulation profiles.',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1616423640778-28d1b53229bd?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1500634245200-e5245c7574ef?w=800&auto=format&fit=crop&q=80',
      ],
      price: 185000.0,
      oldPrice: 198000.0,
      rating: 4.8,
      reviewCount: 167,
      category: 'Camera',
      savePercentage: 7,
      colors: ['Silver', 'Black'],
      specifications: {
        'Sensor': '40.2MP APS-C X-Trans CMOS 5 HR',
        'Video': '6.2K at 30fps, 4K at 60fps, FHD 240fps',
        'Stabilization': 'Up to 7.0 stops 5-axis IBIS',
        'Shutter Speed': 'Up to 1/180,000 sec electronic shutter',
      },
    ),
    ProductModel(
      id: 'cam_3',
      title: 'GoPro HERO 12 Black Action Camera',
      description:
          'Incredible 5.3K video resolution with HDR, HyperSmooth 6.0 stabilization, 8x slow-mo, waterproof up to 33ft without housing, and dual LCD front & rear screens.',
      imageUrl:
          'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?w=800&auto=format&fit=crop&q=80',
      ],
      price: 41500.0,
      oldPrice: 46000.0,
      rating: 4.7,
      reviewCount: 220,
      category: 'Camera',
      savePercentage: 10,
      colors: ['Matte Black'],
      specifications: {
        'Resolution': '5.3K 60fps, 4K 120fps, 2.7K 240fps',
        'Stabilization': 'HyperSmooth 6.0 with 360 Horizon Lock',
        'Waterproof': '10m (33ft) without housing',
        'Battery': '1720mAh Enduro Rechargeable Battery',
      },
    ),

    // ----------------------------------------
    // 3. GIMBALS & STABILIZERS
    // ----------------------------------------
    ProductModel(
      id: 'gim_1',
      title: 'DJI Osmo Mobile 6 Smartphone Stabilizer',
      description:
          'Intelligent smartphone stabilizer with 3-axis stabilization, built-in extension rod, portable and foldable design, side wheel for zoom/focus, and ActiveTrack 6.0.',
      imageUrl:
          'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=800&auto=format&fit=crop&q=80',
      ],
      price: 16500.0,
      oldPrice: 19500.0,
      rating: 4.8,
      reviewCount: 194,
      category: 'Gimbal',
      savePercentage: 15,
      colors: ['Slate Grey', 'Platinum White'],
      specifications: {
        'Stabilization': '3-Axis Motorized Gimbal',
        'Tracking': 'ActiveTrack 6.0 subject tracking',
        'Extension Rod': 'Built-in 215mm telescopic rod',
        'Battery Life': 'Approx. 6.5 Hours (1000mAh)',
        'Weight': '309g (Payload up to 290g)',
      },
    ),
    ProductModel(
      id: 'gim_2',
      title: 'DJI RS 3 Mini Gimbal for Camera',
      description:
          'Ultra-compact lightweight stabilizer for mirrorless cameras. Weighs just 795g, supports up to 2kg payload, native vertical shooting, and Bluetooth shutter control.',
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800&auto=format&fit=crop&q=80',
      ],
      price: 38500.0,
      oldPrice: 42000.0,
      rating: 4.9,
      reviewCount: 130,
      category: 'Gimbal',
      savePercentage: 8,
      colors: ['Matte Black'],
      specifications: {
        'Tested Payload': '2 kg (4.4 lbs)',
        'Weight': '795g (Portrait Mode)',
        'Screen': '1.4-inch Full-Color Touchscreen',
        'Battery Life': 'Up to 10 Hours continuous runtime',
      },
    ),

    // ----------------------------------------
    // 4. ACCESSORIES (AUDIO & POWER)
    // ----------------------------------------
    ProductModel(
      id: 'acc_1',
      title: 'Sony WH-1000XM5 Wireless ANC Headphones',
      description:
          'Industry-leading noise cancellation powered by two processors and 8 microphones. High-Resolution Audio with 30mm precision drivers, crystal-clear hands-free calls, and 30-hour battery.',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=800&auto=format&fit=crop&q=80',
      ],
      price: 36990.0,
      oldPrice: 44990.0,
      rating: 4.9,
      reviewCount: 520,
      category: 'Accessories',
      savePercentage: 18,
      colors: ['Silver', 'Black', 'Midnight Blue'],
      specifications: {
        'Noise Cancelling': 'Dual Processor V1 + HD QN1 with 8 mics',
        'Battery': 'Up to 30 Hours (3 min charge = 3 hours play)',
        'Codecs': 'LDAC, AAC, SBC, Hi-Res Audio Wireless',
        'Weight': '250g ultra-lightweight fit',
      },
    ),
    ProductModel(
      id: 'acc_2',
      title: 'Apple AirPods Pro 2 (USB-C MagSafe)',
      description:
          'Up to 2x more Active Noise Cancellation, Adaptive Audio that tailors noise control to your environment, Transparency mode, and Personalized Spatial Audio with dynamic head tracking.',
      imageUrl:
          'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800&auto=format&fit=crop&q=80',
      ],
      price: 26500.0,
      oldPrice: 31000.0,
      rating: 4.8,
      reviewCount: 410,
      category: 'Accessories',
      savePercentage: 15,
      colors: ['White'],
      specifications: {
        'Chip': 'Apple H2 headphone chip + U1 in case',
        'Battery': '6 hours single charge, 30 hours with case',
        'Water Resistance': 'IP54 dust, sweat, and water resistant',
        'Charging': 'USB-C, MagSafe, Apple Watch charger compatible',
      },
    ),
    ProductModel(
      id: 'acc_3',
      title: 'Anker 737 PowerBank (PowerCore 24K, 140W)',
      description:
          'Equipped with Power Delivery 3.1 and bi-directional technology to quickly recharge the portable charger or deliver a 140W ultra-powerful charge to laptops, tablets, and phones.',
      imageUrl:
          'https://images.unsplash.com/photo-1609592424109-dd9892f1b177?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1609592424109-dd9892f1b177?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1622445262464-84b1456045b6?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1585338107529-13afc5f02586?w=800&auto=format&fit=crop&q=80',
      ],
      price: 11999.0,
      oldPrice: 14500.0,
      rating: 4.9,
      reviewCount: 244,
      category: 'Accessories',
      savePercentage: 17,
      colors: ['Black / Charcoal'],
      specifications: {
        'Capacity': '24,000mAh high-density battery',
        'Max Output': '140W Fast Charging across 3 ports',
        'Display': 'Smart digital color screen with realtime metrics',
        'Ports': '2x USB-C + 1x USB-A',
      },
    ),
    ProductModel(
      id: 'acc_4',
      title: 'Anker Soundcore R50i TWS Earbuds',
      description:
          'Extra-bass true wireless earbuds with 10mm drivers, 30 hours of playtime with charging case, IPX5 waterproof rating, and 2 AI-enhanced clear call microphones.',
      imageUrl:
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=800&auto=format&fit=crop&q=80',
      ],
      price: 1999.0,
      oldPrice: 2499.0,
      rating: 4.7,
      reviewCount: 520,
      category: 'Accessories',
      savePercentage: 20,
      colors: ['Black', 'White', 'Navy Blue'],
      specifications: {
        'Driver': '10mm BassBoost Dynamic Driver',
        'Playtime': '10H per charge (30H with case)',
        'Water Resistance': 'IPX5 sweat and splash proof',
        'App Support': 'Soundcore App with 22 preset EQs',
      },
    ),
    ProductModel(
      id: 'acc_oos_1',
      title: 'Sony WH-1000XM4 Noise Cancelling (OOS)',
      description:
          'The WH-1000XM4 delivers exceptional noise cancellation and smart listening technology that adjusts to your environment automatically.',
      imageUrl:
          'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=80',
      ],
      price: 28500.0,
      oldPrice: 34000.0,
      rating: 0.0,
      reviewCount: 0,
      category: 'Accessories',
      inStock: false,
      savePercentage: 15,
      colors: [],
      specifications: {},
    ),

    // ----------------------------------------
    // 5. PROJECTORS
    // ----------------------------------------
    ProductModel(
      id: 'proj_1',
      title: 'Xiaomi Wanbo T2 Max Auto Focus Projector',
      description:
          'Native 1080P Full HD smart home projector with 450 ANSI Lumens, AI auto-focus, automatic keystone correction, dual 3W Hi-Fi stereo speakers, and official Android TV.',
      imageUrl:
          'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?w=800&auto=format&fit=crop&q=80',
      ],
      price: 18500.0,
      oldPrice: 22000.0,
      rating: 4.6,
      reviewCount: 112,
      category: 'Projector',
      savePercentage: 16,
      colors: ['Glacier White', 'Midnight Blue'],
      specifications: {
        'Native Resolution': '1920 x 1080P Full HD',
        'Brightness': '450 ANSI Lumens',
        'Screen Projection': '40 to 140 inches',
        'Focus': 'Auto-Focus & 4-Point Keystone Correction',
        'Audio': 'Dual 3W Hi-Fi Chamber Speakers',
      },
    ),
    ProductModel(
      id: 'proj_2',
      title: 'XGIMI Horizon Pro 4K Home Cinema Projector',
      description:
          'Stunning true 4K resolution (3840x2160) with 1500 ISO lumens, dual 8W Harman Kardon acoustic sound system, intelligent screen adaptation, and optical zoom.',
      imageUrl:
          'https://images.unsplash.com/photo-1595769816263-9b910be24d5f?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1595769816263-9b910be24d5f?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=800&auto=format&fit=crop&q=80',
      ],
      price: 185000.0,
      oldPrice: 210000.0,
      rating: 4.9,
      reviewCount: 88,
      category: 'Projector',
      savePercentage: 12,
      colors: ['Space Gray'],
      specifications: {
        'Resolution': '3840 x 2160 pixels (True 4K UHD)',
        'Brightness': '1500 ISO Lumens',
        'Sound': '2 x 8W Harman Kardon with DTS Studio Sound',
        'Throw Ratio': '1.2:1 (Projects up to 200 inches)',
      },
    ),

    // ----------------------------------------
    // 6. MICROPHONES
    // ----------------------------------------
    ProductModel(
      id: 'mic_1',
      title: 'Blue Yeti USB Multi-Pattern Condenser Mic',
      description:
          'The world’s #1 premium USB microphone for podcasting, streaming, YouTube videos, and vocal recording. Features 4 selectable polar patterns and zero-latency headphone monitoring.',
      imageUrl:
          'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1590602847861-f357a9332bbc?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1520523839898-507125ef538a?w=800&auto=format&fit=crop&q=80',
      ],
      price: 14500.0,
      oldPrice: 17500.0,
      rating: 4.8,
      reviewCount: 340,
      category: 'Microphone',
      savePercentage: 17,
      colors: ['Blackout', 'Silver', 'Midnight Blue'],
      specifications: {
        'Capsules': '3 Blue-proprietary 14mm condenser capsules',
        'Polar Patterns': 'Cardioid, Bidirectional, Omnidirectional, Stereo',
        'Sample Rate': '48kHz / 16-bit',
        'Frequency Response': '20Hz - 20kHz',
      },
    ),
    ProductModel(
      id: 'mic_2',
      title: 'Rode Wireless PRO Dual-Channel Wireless Mic',
      description:
          'Compact wireless microphone system with 32-bit float on-board recording, 260m transmission range, GainAssist technology, internal timecode generator, and lavalier mics included.',
      imageUrl:
          'https://images.unsplash.com/photo-1543616948-6444d629a8a7?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1543616948-6444d629a8a7?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1590602847861-f357a9332bbc?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=800&auto=format&fit=crop&q=80',
      ],
      price: 46000.0,
      oldPrice: 52000.0,
      rating: 4.9,
      reviewCount: 95,
      category: 'Microphone',
      savePercentage: 12,
      colors: ['Matte Black'],
      specifications: {
        'Range': '260m line-of-sight digital transmission (2.4GHz)',
        'Internal Recording': '32GB storage per transmitter (over 40 hours)',
        'Audio Tech': '32-bit Float Recording & Intelligent GainAssist',
        'Battery Life': 'Up to 7 hours runtime (Smart Charge Case included)',
      },
    ),

    // ----------------------------------------
    // 7. ROUTERS
    // ----------------------------------------
    ProductModel(
      id: 'rou_1',
      title: 'TP-Link Archer AX73 Dual-Band Wi-Fi 6 Router',
      description:
          'Gigabit Wi-Fi 6 router reaching speeds up to 5400 Mbps. Equipped with 6 high-gain antennas, OneMesh support, 4T4R MU-MIMO, HomeShield security, and USB 3.0 file sharing.',
      imageUrl:
          'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1606904825846-647eb07f5be2?w=800&auto=format&fit=crop&q=80',
      ],
      price: 12800.0,
      oldPrice: 14990.0,
      rating: 4.7,
      reviewCount: 168,
      category: 'Router',
      savePercentage: 15,
      colors: ['Black'],
      specifications: {
        'Wi-Fi Speed': '4804 Mbps (5 GHz) + 574 Mbps (2.4 GHz)',
        'Antennas': '6 high-performance external antennas with Beamforming',
        'Processor': '1.5 GHz Triple-Core CPU',
        'Ports': '1x Gigabit WAN + 4x Gigabit LAN + 1x USB 3.0',
      },
    ),
    ProductModel(
      id: 'rou_2',
      title: 'ASUS ROG Rapture GT-AX6000 Gaming Router',
      description:
          'High-efficiency WiFi 6 gaming router with dual 2.5G ports, quad-core 2.0 GHz 64-bit CPU, RangeBoost Plus, Aura RGB lighting, and triple-level game acceleration.',
      imageUrl:
          'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1526738549149-8e07eca6c147?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&auto=format&fit=crop&q=80',
      ],
      price: 38500.0,
      oldPrice: 43000.0,
      rating: 4.9,
      reviewCount: 84,
      category: 'Router',
      savePercentage: 10,
      colors: ['ROG Black & Red'],
      specifications: {
        'Speed': 'Up to 6000 Mbps (1148 + 4804 Mbps)',
        'Network Ports': 'Dual 2.5G Multi-Gigabit Ethernet Ports',
        'CPU': '2.0 GHz 64-bit Quad-Core Broadcom Processor',
        'Special': 'Aura RGB lighting and Mobile Game Mode',
      },
    ),

    // ----------------------------------------
    // 8. TABLETS
    // ----------------------------------------
    ProductModel(
      id: 'tab_1',
      title: 'iPad Air M2 (11-inch Liquid Retina)',
      description:
          'The redesigned 11-inch iPad Air supercharged by the blazing-fast Apple M2 chip. Features an immersive Liquid Retina display, landscape 12MP front camera with Center Stage, and Apple Pencil Pro support.',
      imageUrl:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1585790050230-5dd28404ccb9?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800&auto=format&fit=crop&q=80',
      ],
      price: 78500.0,
      oldPrice: 86000.0,
      rating: 4.9,
      reviewCount: 450,
      category: 'Tablet',
      savePercentage: 9,
      colors: ['Space Gray', 'Blue', 'Purple', 'Starlight'],
      specifications: {
        'Processor': 'Apple M2 chip with 8-core CPU & 9-core GPU',
        'Display': '11-inch Liquid Retina Display with P3 Wide Color',
        'Storage': '128GB / 256GB / 512GB',
        'Camera': '12MP Wide back camera & Landscape 12MP Ultra Wide',
        'Battery': 'Up to 10 hours of web surfing on Wi-Fi',
      },
    ),
    ProductModel(
      id: 'tab_2',
      title: 'Samsung Galaxy Tab S9 Ultra (14.6-inch)',
      description:
          'The pinnacle of premium Android tablets. Giant 14.6-inch Dynamic AMOLED 2X display (120Hz), Snapdragon 8 Gen 2 for Galaxy, IP68 water & dust resistance, and bundled low-latency S Pen.',
      imageUrl:
          'https://images.unsplash.com/photo-1585790050230-5dd28404ccb9?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1585790050230-5dd28404ccb9?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=800&auto=format&fit=crop&q=80',
      ],
      price: 125000.0,
      oldPrice: 139000.0,
      rating: 4.8,
      reviewCount: 178,
      category: 'Tablet',
      savePercentage: 10,
      colors: ['Graphite', 'Beige'],
      specifications: {
        'Display': '14.6-inch Dynamic AMOLED 2X, 120Hz, HDR10+',
        'Processor': 'Qualcomm Snapdragon 8 Gen 2 for Galaxy',
        'Battery': '11,200mAh with 45W Fast Charging',
        'Water Resistance': 'IP68 tablet and S Pen',
        'Speakers': 'Quad AKG stereo speakers with Dolby Atmos',
      },
    ),

    // ----------------------------------------
    // 9. SMARTPHONES
    // ----------------------------------------
    ProductModel(
      id: 'ph_1',
      title: 'Apple iPhone 16 Pro Max (256GB Titanium)',
      description:
          'Forged in Grade 5 titanium with an expansive 6.9-inch Super Retina XDR display. Powered by the groundbreaking A18 Pro chip, 48MP Fusion camera system with 5x Telephoto zoom, and Camera Control button.',
      imageUrl:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800&auto=format&fit=crop&q=80',
      ],
      price: 175000.0,
      oldPrice: 189000.0,
      rating: 4.9,
      reviewCount: 680,
      category: 'Smartphones',
      savePercentage: 7,
      colors: ['Desert Titanium', 'Natural Titanium', 'Black Titanium', 'White Titanium'],
      specifications: {
        'Display': '6.9-inch OLED ProMotion 120Hz Always-On',
        'Chip': 'Apple A18 Pro (3nm) with 6-core GPU',
        'Cameras': '48MP Main + 48MP Ultra Wide + 12MP 5x Telephoto',
        'Battery': 'Up to 33 hours video playback, MagSafe wireless',
      },
    ),
    ProductModel(
      id: 'ph_2',
      title: 'Samsung Galaxy S24 Ultra (512GB)',
      description:
          'Next-gen mobile AI experience with Galaxy AI. Features a 6.8-inch flat Dynamic AMOLED 2X display, 200MP camera with Quad Telephoto system, built-in S Pen, and titanium frame.',
      imageUrl:
          'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=800&auto=format&fit=crop&q=80',
      images: [
        'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800&auto=format&fit=crop&q=80',
      ],
      price: 155000.0,
      oldPrice: 172000.0,
      rating: 4.8,
      reviewCount: 512,
      category: 'Smartphones',
      savePercentage: 10,
      colors: ['Titanium Gray', 'Titanium Black', 'Titanium Violet'],
      specifications: {
        'Display': '6.8-inch QHD+ 120Hz Corning Gorilla Armor',
        'Processor': 'Snapdragon 8 Gen 3 for Galaxy',
        'Camera': '200MP + 50MP 5x + 10MP 3x + 12MP Ultra Wide',
        'Battery': '5000mAh with 45W Fast Charging',
      },
    ),
  ];

  // ==========================================
  // QUERY HELPER METHODS
  // ==========================================

  /// Featured products for Home Screen banner & highlights
  static List<ProductModel> get featuredProducts => [
        products.firstWhere((p) => p.id == 'sw_1'), // Apple Watch Ultra 2
        products.firstWhere((p) => p.id == 'gim_1'), // DJI Osmo Mobile 6
        products.firstWhere((p) => p.id == 'acc_1'), // Sony WH-1000XM5
        products.firstWhere((p) => p.id == 'cam_1'), // Sony A7 IV
      ];

  /// Best Sellers
  static List<ProductModel> get bestSellers => [
        products.firstWhere((p) => p.id == 'tab_1'), // iPad Air M2
        products.firstWhere((p) => p.id == 'acc_2'), // AirPods Pro 2
        products.firstWhere((p) => p.id == 'mic_1'), // Blue Yeti
        products.firstWhere((p) => p.id == 'sw_2'),  // Galaxy Watch 6 Classic
      ];

  /// Hot Deals with high discount %
  static List<ProductModel> get hotDeals => [
        products.firstWhere((p) => p.id == 'acc_4'), // Soundcore R50i (20% off)
        products.firstWhere((p) => p.id == 'acc_1'), // Sony WH-1000XM5 (18% off)
        products.firstWhere((p) => p.id == 'acc_3'), // Anker 737 (17% off)
        products.firstWhere((p) => p.id == 'proj_1'), // Wanbo T2 Max (16% off)
      ];

  /// Recommended products
  static List<ProductModel> get recommendedProducts => [
        products.firstWhere((p) => p.id == 'acc_oos_1'), // Sony WH-1000XM4 (OOS)
        products.firstWhere((p) => p.id == 'ph_1'),  // iPhone 16 Pro Max
        products.firstWhere((p) => p.id == 'cam_3'), // GoPro Hero 12
        products.firstWhere((p) => p.id == 'rou_1'), // TP-Link AX73
        products.firstWhere((p) => p.id == 'tab_2'), // Tab S9 Ultra
      ];

  /// Get products by exact or partial category name
  static List<ProductModel> getProductsByCategory(String categoryName) {
    final query = categoryName.trim().toLowerCase();
    if (query == 'all' || query.isEmpty) return products;
    return products
        .where((p) => p.category.toLowerCase().contains(query))
        .toList();
  }

  /// Get single product by id
  static ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search products by keyword
  static List<ProductModel> searchProducts(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.trim().toLowerCase();
    return products.where((p) {
      return p.title.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q);
    }).toList();
  }

  /// Authentic gadget customer reviews from design
  static const List<ReviewModel> productReviews = [
    ReviewModel(
      id: 'rev_1',
      author: 'Aisha Rahman',
      rating: 5,
      date: '12 Mar 2026',
      comment:
          "These are hands-down the best over-ears I've owned. The sound is incredibly detailed, noise cancellation is almost silent, and they stay comfortable even after a full day of travel.",
    ),
    ReviewModel(
      id: 'rev_2',
      author: 'Omar Khan',
      rating: 4,
      date: '08 Mar 2026',
      comment:
          'Great overall, but the case feels a bit larger than I expected and the touch controls can be finicky sometimes. Still, the sound quality and ANC are worth it.',
    ),
    ReviewModel(
      id: 'rev_3',
      author: 'Priya Sengupta',
      rating: 5,
      date: '02 Mar 2026',
      comment:
          'Perfect for long flights. The ANC is incredible in loud environments and the battery life easily lasts a full day. Highly recommend for anyone who values silence and clear sound.',
    ),
    ReviewModel(
      id: 'rev_4',
      author: 'Rafiq Hasan',
      rating: 5,
      date: '25 Feb 2026',
      comment:
          'Absolutely fantastic sound signature and the battery life easily lasts more than my continuous work shifts. Worth every single taka if you value pure quality.',
    ),
    ReviewModel(
      id: 'rev_5',
      author: 'Nadia Islam',
      rating: 5,
      date: '18 Feb 2026',
      comment:
          'Excellent noise cancellation and sound, though they are quite pricey. The premium build feels luxurious, but I suggest getting it during a sale.',
    ),
    ReviewModel(
      id: 'rev_6',
      author: 'Tanvir Ahmed',
      rating: 4,
      date: '10 Feb 2026',
      comment:
          'Decent headphones, but I expected a bit more punchy bass out of the box. Midtones and vocals are crystal clear, but bassheads might need to tweak EQ settings extensively.',
    ),
    ReviewModel(
      id: 'rev_7',
      author: 'Samira Begum',
      rating: 5,
      date: '03 Feb 2026',
      comment:
          "Best purchase I've made this year. Worth every single taka! Noise cancellation literally blocks out the chaotic city traffic sound completely.",
    ),
  ];
}
