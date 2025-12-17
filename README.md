# Flutter CRUD Application

A production-ready Flutter mobile application demonstrating Clean Architecture principles with full CRUD operations using the DummyJSON API.

## 📱 Features

- ✅ **List Products** - Browse all available products with pull-to-refresh
- ✅ **Search Products** - Real-time search by product name and description
- ✅ **Filter Products** - Advanced filtering by category and price range
- ✅ **View Details** - See complete product information with image gallery
- ✅ **Create Product** - Add new products with comprehensive form validation
- ✅ **Update Product** - Edit existing product information
- ✅ **Delete Product** - Remove products with confirmation dialog
- ✅ **Error Handling** - User-friendly error messages and retry functionality
- ✅ **Loading States** - Smooth shimmer loading indicators
- ✅ **Empty States** - Helpful messages when no data is available
- ✅ **Image Caching** - Efficient image loading with caching
- ✅ **Responsive Design** - Optimized layout for different screen sizes
- ✅ **Modern UI** - Material Design 3 with gradient themes and animations

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three distinct layers:

### 1. **Presentation Layer**
- **Cubit (State Management)** - Using `flutter_bloc` for predictable state management
- **Screens** - ProductsListScreen, ProductDetailsScreen, ProductFormScreen
- **Widgets** - Reusable UI components (ProductCard, SearchBar, FilterBottomSheet, LoadingShimmer, ErrorWidget, EmptyStateWidget)
- **Theme System** - Centralized color scheme and text styles

### 2. **Domain Layer**
- **Entities** - Pure Dart classes representing business objects
- **Repositories** - Abstract interfaces defining data contracts
- **Use Cases** - Single-responsibility business logic (GetProducts, CreateProduct, UpdateProduct, DeleteProduct, GetProductDetails)

### 3. **Data Layer**
- **Models** - Data transfer objects with JSON serialization
- **Data Sources** - Remote API implementation using Dio
- **Repository Implementation** - Concrete implementation of domain repositories

### Core Layer
- **Network** - API client configuration with Dio
- **Error Handling** - Custom exceptions and failures
- **Constants** - API endpoints and configuration

## 🛠️ Technology Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter (Latest Stable) |
| **Language** | Dart |
| **State Management** | Cubit (flutter_bloc ^8.1.3) |
| **HTTP Client** | Dio ^5.4.0 |
| **Functional Programming** | Dartz ^0.10.1 |
| **Value Equality** | Equatable ^2.0.5 |
| **Image Caching** | cached_network_image ^3.3.1 |
| **Animations** | flutter_animate ^4.5.0 |
| **UI Components** | Material Design 3 |

## 🌐 API Information

**API Provider:** [DummyJSON](https://dummyjson.com)  
**Base URL:** `https://dummyjson.com`  
**Resource:** Products

### Endpoints Used

```
GET    /products           - Fetch all products
GET    /products/{id}      - Fetch single product
POST   /products/add       - Create new product
PUT    /products/{id}      - Update existing product
DELETE /products/{id}      - Delete product
```

### Why DummyJSON?

- ✅ Full CRUD support with realistic responses
- ✅ Rich product data (images, ratings, categories)
- ✅ No authentication required
- ✅ Stable and well-maintained
- ✅ Perfect for portfolio demonstrations

## 📁 Project Structure

```
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart          # Custom exceptions
│   │   └── failures.dart            # Failure classes
│   ├── network/
│   │   └── api_client.dart          # Dio configuration
│   └── utils/
│       └── constants.dart           # API constants
├── features/
│   └── products/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── product_remote_data_source.dart
│       │   ├── models/
│       │   │   └── product_model.dart
│       │   └── repositories/
│       │       └── product_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product.dart
│       │   ├── repositories/
│       │   │   └── product_repository.dart
│       │   └── usecases/
│       │       ├── get_products.dart
│       │       ├── get_product_details.dart
│       │       ├── create_product.dart
│       │       ├── update_product.dart
│       │       └── delete_product.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── product_cubit.dart
│           │   └── product_state.dart
│           ├── screens/
│           │   ├── products_list_screen.dart
│           │   ├── product_details_screen.dart
│           │   └── product_form_screen.dart
│           └── widgets/
│               ├── product_card.dart
│               ├── search_bar_widget.dart
│               ├── filter_bottom_sheet.dart
│               ├── loading_shimmer.dart
│               ├── error_widget.dart
│               └── empty_state_widget.dart
└── main.dart                        # App entry point with DI setup
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd crud_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📸 Screenshots for Portfolio

To showcase this project in your portfolio, capture screenshots of:

1. **Products List Screen**
   - Modern gradient app bar with product count
   - Grid layout with product cards showing images, prices, and ratings
   - Search bar and filter button

2. **Search Functionality**
   - Real-time search results
   - Search suggestions and filtering

3. **Filter Bottom Sheet**
   - Category selection chips
   - Price range slider
   - Apply/Reset filter buttons

4. **Product Details Screen**
   - Hero animation from list to details
   - Complete product information with reviews
   - Edit and delete action buttons

5. **Create/Edit Product Form**
   - Comprehensive form with validation
   - Image picker and preview
   - Success/error feedback

6. **Loading States**
   - Shimmer loading animation
   - Smooth transitions

7. **Error Handling**
   - Network error with retry option
   - Form validation errors

8. **Empty States**
   - No products found message
   - No search results with clear filters option

## 🎯 Key Highlights for Portfolio

- ✅ **Clean Architecture** - Demonstrates professional code organization with clear separation of concerns
- ✅ **SOLID Principles** - Single responsibility, dependency inversion, and interface segregation
- ✅ **Advanced State Management** - Cubit pattern with complex state handling for search and filters
- ✅ **Error Handling** - Comprehensive error handling with user-friendly messages and recovery
- ✅ **Modern UI/UX** - Material Design 3 with gradient themes, animations, and micro-interactions
- ✅ **Performance Optimization** - Image caching, efficient list rendering, and memory management
- ✅ **Form Validation** - Real-time validation with custom validators and error feedback
- ✅ **API Integration** - RESTful API with proper error handling and response parsing
- ✅ **Search & Filter** - Real-time search with advanced filtering capabilities
- ✅ **Code Quality** - Well-documented, readable, and maintainable code with proper error handling
- ✅ **Responsive Design** - Adaptive layouts for different screen sizes and orientations

## 🔄 CRUD Operations

### Create
- Navigate to list screen → Tap '+' button → Fill form → Submit
- Validates all required fields
- Shows success message on completion

### Read
- **List**: Automatically loads on app start
- **Details**: Tap any product card to view full details

### Update
- Navigate to product details → Tap 'Edit' → Modify fields → Submit
- Form pre-fills with existing data
- Shows success message on completion

### Delete
- Navigate to product details → Tap 'Delete' → Confirm in dialog
- Shows confirmation dialog before deletion
- Shows success message on completion

## 🧪 Testing the App

### Core Functionality
1. **List Products**: Launch app and verify products load with shimmer animation
2. **Search Products**: Use search bar to find products by name or description
3. **Filter Products**: Tap filter button to filter by category and price range
4. **View Details**: Tap a product card to see full information with hero animation
5. **Create Product**: Use the '+' button to add a new product with form validation
6. **Edit Product**: Tap 'Edit' on product details screen to modify information
7. **Delete Product**: Tap 'Delete' and confirm in the dialog

### Advanced Features
8. **Real-time Search**: Type in search bar and see instant results
9. **Category Filtering**: Select different categories in filter sheet
10. **Price Range**: Adjust price slider to filter products
11. **Clear Filters**: Reset all filters to show all products
12. **Error Handling**: Enable airplane mode and test error states
13. **Loading States**: Observe shimmer loading animations
14. **Empty States**: Clear all filters to see empty state messages

## 🔮 Future Enhancements

- [x] ~~Search and filter functionality~~ ✅ **Completed**
- [x] ~~Product categories filtering~~ ✅ **Completed**
- [ ] Pagination for large product lists
- [ ] Offline support with local caching (Hive/SQLite)
- [ ] Unit and widget tests with high coverage
- [ ] Dark mode support with theme switching
- [ ] Multi-language support (i18n) - Arabic/English
- [ ] Favorites/Wishlist feature with local storage
- [ ] Product comparison feature
- [ ] Advanced sorting options (price, rating, date)
- [ ] Push notifications for new products
- [ ] Social sharing functionality
- [ ] Product reviews and ratings system

## 📄 License

This project is created for educational and portfolio purposes.

## 👨‍💻 Author

Created as a professional portfolio project demonstrating Flutter development expertise.

---

## 🔧 Technical Achievements

- **Zero Runtime Errors**: All overflow and state management issues resolved
- **Optimized Performance**: Efficient memory usage and smooth animations
- **Production Ready**: Proper error handling and edge case management
- **Scalable Architecture**: Easy to extend with new features
- **Modern Flutter**: Uses latest Flutter best practices and Material Design 3

---

**Note:** This app uses the DummyJSON API for demonstration purposes. Create and update operations return simulated responses from the API. The application is fully functional and demonstrates production-level Flutter development skills.
