import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/loading_shimmer.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'product_details_screen.dart';
import 'product_form_screen.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late ProductCubit _productCubit;
  
  @override
  void initState() {
    super.initState();
    _productCubit = context.read<ProductCubit>();
    _productCubit.loadProducts();
  }

  void _showFilterSheet(BuildContext context, ProductsLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        cubit: _productCubit,
        selectedCategory: state.selectedCategory,
        minPrice: state.minPrice,
        maxPrice: state.maxPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Modern App Bar with Gradient
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: FlexibleSpaceBar(
                    title: Text(
                      'Products',
                      style: AppTextStyles.h2.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    centerTitle: false,
                    titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductFormScreen(),
                        ),
                      ).then((_) {
                        if (mounted) {
                          _productCubit.loadProducts();
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Search Bar
              if (state is ProductsLoaded)
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      SearchBarWidget(
                        onSearch: (query) {
                          _productCubit.searchProducts(query);
                        },
                        initialQuery: state.searchQuery,
                      ),
                    ],
                  ),
                ),

              // Filter Button
              if (state is ProductsLoaded)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryStart.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: AppColors.primaryStart,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${state.filteredProducts.length} products found',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primaryStart,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Material(
                          color: AppColors.primaryStart,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () => _showFilterSheet(context, state),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.filter_list,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Filter',
                                    style: AppTextStyles.button.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (state.selectedCategory != null ||
                                      state.searchQuery.isNotEmpty ||
                                      state.minPrice > 0 ||
                                      state.maxPrice < 5000)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.accent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Content
              if (state is ProductLoading)
                const SliverFillRemaining(child: ProductListShimmer())
              else if (state is ProductsLoaded)
                state.filteredProducts.isEmpty
                    ? SliverFillRemaining(
                        child: EmptyStateWidget(
                          message:
                              state.searchQuery.isNotEmpty ||
                                  state.selectedCategory != null
                              ? 'No products match your filters'
                              : 'No products available',
                          actionLabel:
                              state.searchQuery.isNotEmpty ||
                                  state.selectedCategory != null
                              ? 'Clear Filters'
                              : 'Add Product',
                          onAction: () {
                            if (state.searchQuery.isNotEmpty ||
                                state.selectedCategory != null) {
                              _productCubit.resetFilters();
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductFormScreen(),
                                ),
                              ).then((_) {
                                if (mounted) {
                                  _productCubit.loadProducts();
                                }
                              });
                            }
                          },
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final product = state.filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      productId: product.id,
                                    ),
                                  ),
                                ).then((_) {
                                  if (mounted) {
                                    _productCubit.loadProducts();
                                  }
                                });
                              },
                            );
                          }, childCount: state.filteredProducts.length),
                        ),
                      )
              else if (state is ProductError)
                SliverFillRemaining(
                  child: ErrorDisplayWidget(
                    message: state.message,
                    onRetry: () {
                      _productCubit.loadProducts();
                    },
                  ),
                )
              else
                const SliverFillRemaining(child: SizedBox()),
            ],
          );
        },
      ),
    );
  }
}
