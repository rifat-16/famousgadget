import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock_database.dart';
import '../../models/product_model.dart';
import '../../models/review_model.dart';

class AllReviewsView extends StatefulWidget {
  const AllReviewsView({super.key});

  @override
  State<AllReviewsView> createState() => _AllReviewsViewState();
}

class _AllReviewsViewState extends State<AllReviewsView> {
  String _selectedFilter = 'Most Recent';
  late final ProductModel? _product;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is ProductModel) {
      _product = args;
    } else {
      _product = null;
    }
  }

  List<ReviewModel> _getFilteredReviews() {
    final list = List<ReviewModel>.from(MockDatabase.productReviews);
    switch (_selectedFilter) {
      case 'Highest Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Lowest Rating':
        list.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case 'Most Recent':
      default:
        // Already in recent order
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final rating = _product?.rating ?? 4.8;
    final reviewCount = _product?.reviewCount ?? 142;
    final reviews = _getFilteredReviews();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navyDark),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'All Reviews',
          style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Summary Card
            Container(
              padding: const EdgeInsets.all(AppSpacing.s16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: AppRadius.radiusAll16,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  // Left: Average Score
                  SizedBox(
                    width: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: AppTextStyles.price(size: 40.0).copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.navyDark,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: AppColors.amber,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        Text(
                          '$reviewCount Reviews',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Container(
                    height: 90,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                    color: AppColors.borderLight,
                  ),

                  // Right: Rating Breakdown
                  Expanded(
                    child: Column(
                      children: [
                        _buildBreakdownRow(5, 0.70, '70%'),
                        const SizedBox(height: 6),
                        _buildBreakdownRow(4, 0.18, '18%'),
                        const SizedBox(height: 6),
                        _buildBreakdownRow(3, 0.07, '7%'),
                        const SizedBox(height: 6),
                        _buildBreakdownRow(2, 0.03, '3%'),
                        const SizedBox(height: 6),
                        _buildBreakdownRow(1, 0.02, '2%'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s16),

            // Sort / Filter Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterTab('Most Recent'),
                  const SizedBox(width: AppSpacing.s8),
                  _buildFilterTab('Highest Rating'),
                  const SizedBox(width: AppSpacing.s8),
                  _buildFilterTab('Lowest Rating'),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s16),

            // Reviews List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s12),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(review);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(int star, double fraction, String percent) {
    return Row(
      children: [
        Text(
          '$star',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.star_rounded, size: 10, color: AppColors.amber),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              backgroundColor: AppColors.pageBackground,
              color: AppColors.primaryOrange,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 26,
          child: Text(
            percent,
            textAlign: TextAlign.end,
            style: AppTextStyles.small.copyWith(
              color: AppColors.textMuted,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(AppRadius.r16),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.borderLight,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.cardWhite : AppColors.navyDark,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: AppRadius.radiusAll16,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        review.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.navyDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: index < review.rating
                              ? AppColors.amber
                              : AppColors.borderLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s8),
              Text(
                review.date,
                style: AppTextStyles.small.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(
            review.comment,
            style: AppTextStyles.bodyRegular.copyWith(
              color: AppColors.navyDark,
              height: 1.4,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
