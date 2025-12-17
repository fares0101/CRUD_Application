import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/create_product.dart';
import 'features/products/domain/usecases/delete_product.dart';
import 'features/products/domain/usecases/get_product_details.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/update_product.dart';
import 'features/products/presentation/cubit/product_cubit.dart';
import 'features/products/presentation/screens/products_list_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection
    final apiClient = ApiClient();
    final ProductRemoteDataSource remoteDataSource =
        ProductRemoteDataSourceImpl(apiClient: apiClient);
    final ProductRepository repository = ProductRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );

    // Use Cases
    final getProducts = GetProducts(repository);
    final getProductDetails = GetProductDetails(repository);
    final createProduct = CreateProduct(repository);
    final updateProduct = UpdateProduct(repository);
    final deleteProduct = DeleteProduct(repository);

    return BlocProvider(
      create: (context) => ProductCubit(
        getProducts: getProducts,
        getProductDetails: getProductDetails,
        createProduct: createProduct,
        updateProduct: updateProduct,
        deleteProduct: deleteProduct,
      ),
      child: MaterialApp(
        title: 'Products CRUD App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => onboardingComplete
              ? const ProductsListScreen()
              : const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
