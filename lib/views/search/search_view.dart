import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../data/mock_database.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final RxList<ProductModel> _results = <ProductModel>[].obs;
  late final List<ProductModel> _allProducts;

  late final AnimationController _animController;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _contentFadeAnimation;
  late final Animation<double> _micScaleAnimation;
  late final Animation<Offset> _cancelSlideAnimation;
  late final Animation<double> _cancelFadeAnimation;
  late final Animation<Offset> _bodySlideAnimation;
  late final Animation<double> _bodyFadeAnimation;

  @override
  void initState() {
    super.initState();
    _allProducts = MockDatabase.products;
    _results.assignAll(_allProducts);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    // Expand search bar horizontally from right to left
    _expandAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.0, 0.75, curve: Curves.easeInCubic),
    );

    // Fade in text field contents
    _contentFadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.25, 0.85, curve: Curves.easeIn),
      reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // Mic button bounce pop
    _micScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.9, curve: Curves.elasticOut),
        reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Cancel text button slides in from right and fades in
    _cancelSlideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0.0, 0.6, curve: Curves.easeInCubic),
      ),
    );

    _cancelFadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeIn),
      reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // Body products grid slides up gently and fades in
    _bodySlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0.0, 0.6, curve: Curves.easeInCubic),
      ),
    );

    _bodyFadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.85, curve: Curves.easeIn),
      reverseCurve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // Trigger the opening animation and request focus smoothly
    _animController.forward().then((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      _results.assignAll(_allProducts);
    } else {
      _results.assignAll(MockDatabase.searchProducts(query));
    }
  }

  void _handleCancel() {
    _focusNode.unfocus();
    _animController.reverse().then((_) {
      if (mounted) {
        Get.back();
      }
    });
  }

  void _onMicTap() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: 72.0,
              height: 72.0,
              decoration: const BoxDecoration(
                color: AppColors.softPeach,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: AppColors.primaryOrange,
                size: 36.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Voice Search',
              style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 18.0),
            ),
            const SizedBox(height: 6.0),
            Text(
              'Tap a keyword or speak into your microphone',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickVoiceChip('Apple Watch'),
                _buildQuickVoiceChip('AirPods Pro'),
                _buildQuickVoiceChip('DJI Osmo'),
                _buildQuickVoiceChip('OnePlus'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickVoiceChip(String text) {
    return ActionChip(
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: AppColors.navyDark,
        ),
      ),
      backgroundColor: AppColors.pageBackground,
      side: const BorderSide(color: AppColors.borderLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      onPressed: () {
        Get.back();
        _searchController.text = text;
        _onSearch(text);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleCancel();
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: Column(
          children: [
            _buildSearchHeader(),
            Expanded(
              child: SlideTransition(
                position: _bodySlideAnimation,
                child: FadeTransition(
                  opacity: _bodyFadeAnimation,
                  child: Obx(
                    () => _results.isEmpty
                        ? _buildEmptyState()
                        : _buildProductsGrid(cartController),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderLight.withValues(alpha: 0.6),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s8,
            AppSpacing.s16,
            AppSpacing.s12,
          ),
          child: Row(
            children: [
              // Expandable Search Input Field
              Expanded(
                child: AnimatedBuilder(
                  animation: _expandAnimation,
                  builder: (context, child) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        final currentWidth =
                            44.0 + (totalWidth - 44.0) * _expandAnimation.value;

                        return Align(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.0),
                            child: SizedBox(
                              width: currentWidth,
                              height: 44.0,
                              child: OverflowBox(
                                alignment: Alignment.centerLeft,
                                minWidth: totalWidth,
                                maxWidth: totalWidth,
                                minHeight: 44.0,
                                maxHeight: 44.0,
                                child: child,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    padding: const EdgeInsets.only(left: 12.0, right: 6.0),
                    child: FadeTransition(
                      opacity: _contentFadeAnimation,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            size: 18.0,
                            color: Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              onChanged: (query) {
                                _onSearch(query);
                                setState(() {});
                              },
                              style: const TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.navyDark,
                              ),
                              cursorColor: AppColors.primaryOrange,
                              decoration: const InputDecoration(
                                hintText: 'Search products...',
                                hintStyle: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF6B7280),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _onSearch('');
                                setState(() {});
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.cancel_rounded,
                                  size: 18.0,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ),
                          const SizedBox(width: 4.0),
                          ScaleTransition(
                            scale: _micScaleAnimation,
                            child: GestureDetector(
                              onTap: _onMicTap,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mic_rounded,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Cancel text button
              SlideTransition(
                position: _cancelSlideAnimation,
                child: FadeTransition(
                  opacity: _cancelFadeAnimation,
                  child: GestureDetector(
                    onTap: _handleCancel,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid(CartController cartController) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s16,
        100.0,
      ),
      itemCount: _results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.s12,
        mainAxisSpacing: AppSpacing.s12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final product = _results[index];
        return ProductCard(
          product: product,
          onTap: () {
            Get.toNamed(
              AppRoutes.productDetail,
              arguments: product,
            );
          },
          onAddToCart: () {
            cartController.addItem(product);
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: const BoxDecoration(
                color: AppColors.softPeach,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 48.0,
                color: AppColors.primaryOrange,
              ),
            ),
            const SizedBox(height: AppSpacing.s20),
            Text(
              'No Products Found',
              style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 20.0),
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              'We couldn\'t find any gadgets matching "${_searchController.text}".\nTry searching with different keywords.',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.s24),
            ElevatedButton(
              onPressed: () {
                _searchController.clear();
                _onSearch('');
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Text(
                'View All Gadgets',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
