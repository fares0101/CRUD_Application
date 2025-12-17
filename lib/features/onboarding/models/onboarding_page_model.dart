class OnboardingPageModel {
  final String title;
  final String description;
  final String icon;
  final List<String> features;

  const OnboardingPageModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
  });
}

class OnboardingData {
  static const List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Welcome to Products App',
      description: 'Discover and manage amazing products with ease',
      icon: '🛍️',
      features: [
        'Browse thousands of products',
        'Easy product management',
        'Real-time updates',
      ],
    ),
    OnboardingPageModel(
      title: 'Powerful Features',
      description: 'Everything you need to manage your products efficiently',
      icon: '⚡',
      features: [
        'Advanced filtering & search',
        'Create & edit products',
        'Beautiful modern interface',
      ],
    ),
  ];
}
