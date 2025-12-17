import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product_details.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final GetProductDetails getProductDetails;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductCubit({
    required this.getProducts,
    required this.getProductDetails,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    final result = await getProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }

  Future<void> loadProductDetails(int id) async {
    emit(ProductLoading());
    final result = await getProductDetails(id);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductLoaded(product)),
    );
  }

  Future<void> addProduct(Product product) async {
    emit(ProductLoading());
    final result = await createProduct(product);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) =>
          emit(const ProductOperationSuccess('Product created successfully')),
    );
  }

  Future<void> editProduct(Product product) async {
    emit(ProductLoading());
    final result = await updateProduct(product);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) =>
          emit(const ProductOperationSuccess('Product updated successfully')),
    );
  }

  Future<void> removeProduct(int id) async {
    emit(ProductLoading());
    final result = await deleteProduct(id);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) =>
          emit(const ProductOperationSuccess('Product deleted successfully')),
    );
  }

  // Filtering methods
  void searchProducts(String query) {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      final filtered = _applyFilters(
        currentState.products,
        searchQuery: query,
        category: currentState.selectedCategory,
        minPrice: currentState.minPrice,
        maxPrice: currentState.maxPrice,
      );
      emit(
        currentState.copyWith(searchQuery: query, filteredProducts: filtered),
      );
    }
  }

  void filterByCategory(String? category) {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      final filtered = _applyFilters(
        currentState.products,
        searchQuery: currentState.searchQuery,
        category: category,
        minPrice: currentState.minPrice,
        maxPrice: currentState.maxPrice,
      );
      emit(
        currentState.copyWith(
          selectedCategory: category,
          filteredProducts: filtered,
          clearCategory: category == null,
        ),
      );
    }
  }

  void filterByPriceRange(double min, double max) {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      final filtered = _applyFilters(
        currentState.products,
        searchQuery: currentState.searchQuery,
        category: currentState.selectedCategory,
        minPrice: min,
        maxPrice: max,
      );
      emit(
        currentState.copyWith(
          minPrice: min,
          maxPrice: max,
          filteredProducts: filtered,
        ),
      );
    }
  }

  void resetFilters() {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      emit(ProductsLoaded(products: currentState.products));
    }
  }

  List<Product> _applyFilters(
    List<Product> products, {
    String searchQuery = '',
    String? category,
    double minPrice = 0,
    double maxPrice = 5000,
  }) {
    // Ensure valid price range
    final validMinPrice = minPrice.isFinite ? minPrice : 0;
    final validMaxPrice = maxPrice.isFinite ? maxPrice : 5000;
    
    return products.where((product) {
      // Search filter
      final matchesSearch =
          searchQuery.isEmpty ||
          product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(searchQuery.toLowerCase());

      // Category filter
      final matchesCategory =
          category == null ||
          product.category.toLowerCase() == category.toLowerCase();

      // Price filter
      final matchesPrice =
          product.price >= validMinPrice && product.price <= validMaxPrice;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();
  }

  List<String> getAvailableCategories() {
    if (state is ProductsLoaded) {
      final currentState = state as ProductsLoaded;
      return currentState.products.map((p) => p.category).toSet().toList()
        ..sort();
    }
    return [];
  }
}
