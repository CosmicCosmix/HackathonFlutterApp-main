import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import '../../core/app_export.dart';
import '../../core/models/scheme_model.dart';
import '../../core/services/data_service.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PageController _carouselController = PageController();
  int _currentCarouselIndex = 0;
  int _currentNavIndex = 1;
  Set<String> _favorites = {};

  List<SchemeModel> _carouselItems = [];
  List<SchemeModel> _recommendedItems = [];
  bool _isLoading = true;
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _dataService.loadDiscoverSchemes();
      setState(() {
        _carouselItems = data['carousel'] ?? [];
        _recommendedItems = data['recommended'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  void _onSchemeTap(SchemeModel scheme) {
    // Handle scheme tap - can navigate to detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${scheme.title} selected'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
    // Handle navigation
    switch (index) {
      case 0:
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.businessFundingLandingScreen);
        break;
      case 1:
        // Already on this screen
        break;
      case 2:
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.resultsDashboardScreen);
        break;
      case 3:
        // Navigate to profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black_900,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
              color: appTheme.black_800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  // Title with search icon
                  Row(
                    children: [
                      // Search icon
                      Icon(
                        Icons.search,
                        size: 24.h,
                        color: appTheme.white_A700,
                      ),
                      SizedBox(width: 16.h),
                      // Discover title
                      Expanded(
                        child: Center(
                          child: Text(
                            'Discover',
                            style: TextStyleHelper
                                .instance.headline24BlackMerriweather
                                .copyWith(
                              fontSize: 28.fSize,
                              fontWeight: FontWeight.w900,
                              color: appTheme.white_A700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.h), // Balance the search icon
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Tabs
                  TabBar(
                    controller: _tabController,
                    indicatorColor: appTheme.indigo_400,
                    indicatorWeight: 3.h,
                    labelColor: appTheme.indigo_400,
                    unselectedLabelColor: appTheme.grey_500,
                    labelStyle:
                        TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle:
                        TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      Tab(text: 'Popular'),
                      Tab(text: 'Featured'),
                      Tab(text: 'Most Visited'),
                    ],
                  ),
                ],
              ),
            ),
            // Content Area
            Expanded(
              child: Container(
                color: appTheme.black_900,
                margin: EdgeInsets.only(top: 16.h),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: appTheme.indigo_400,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Carousel Section
                            SizedBox(
                              height: 280.h,
                              child: _carouselItems.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No schemes available',
                                        style: TextStyleHelper
                                            .instance.bodyTextMerriweather
                                            .copyWith(
                                                color: appTheme.white_A700),
                                      ),
                                    )
                                  : PageView.builder(
                                      controller: _carouselController,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentCarouselIndex = index;
                                        });
                                      },
                                      itemCount: _carouselItems.length,
                                      itemBuilder: (context, index) {
                                        final item = _carouselItems[index];
                                        final itemId = 'carousel_$index';
                                        return _buildCarouselCard(item, itemId);
                                      },
                                    ),
                            ),
                            SizedBox(height: 12.h),
                            // Carousel dots
                            if (_carouselItems.isNotEmpty)
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _carouselItems.length,
                                    (index) => Container(
                                      width: 8.h,
                                      height: 8.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.h),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentCarouselIndex == index
                                            ? appTheme.indigo_400
                                            : appTheme.deep_purple_100,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 32.h),
                            // Recommended Section Header
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recommended',
                                    style: TextStyleHelper
                                        .instance.headline24BlackMerriweather
                                        .copyWith(
                                      fontSize: 20.fSize,
                                      fontWeight: FontWeight.w700,
                                      color: appTheme.white_A700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle view all navigation
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'View all recommended schemes'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'View All',
                                      style: TextStyleHelper
                                          .instance.bodyTextMerriweather
                                          .copyWith(
                                        fontSize: 14.fSize,
                                        color: appTheme.grey_500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Recommended Grid
                            if (_recommendedItems.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.h),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.h,
                                    mainAxisSpacing: 16.h,
                                    childAspectRatio: 0.85,
                                  ),
                                  itemCount: _recommendedItems.length,
                                  itemBuilder: (context, index) {
                                    final item = _recommendedItems[index];
                                    final itemId = 'recommended_$index';
                                    return _buildRecommendedCard(item, itemId);
                                  },
                                ),
                              )
                            else
                              Padding(
                                padding: EdgeInsets.all(24.h),
                                child: Center(
                                  child: Text(
                                    'No recommended schemes available',
                                    style: TextStyleHelper
                                        .instance.bodyTextMerriweather
                                        .copyWith(color: appTheme.white_A700),
                                  ),
                                ),
                              ),
                            SizedBox(height: 100.h), // Space for bottom nav
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(Icons.home, color: appTheme.indigo_400),
          Icon(Icons.search, color: appTheme.indigo_400),
          Icon(Icons.dashboard, color: appTheme.indigo_400),
          Icon(Icons.person, color: appTheme.indigo_400),
        ],
        inactiveIcons: [
          Icon(Icons.home_outlined, color: appTheme.grey_500),
          Icon(Icons.search_outlined, color: appTheme.grey_500),
          Icon(Icons.dashboard_outlined, color: appTheme.grey_500),
          Icon(Icons.person_outline, color: appTheme.grey_500),
        ],
        color: appTheme.black_800,
        height: 70.h,
        circleWidth: 60.h,
        activeIndex: _currentNavIndex,
        onTap: _onNavTap,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.3),
        elevation: 8,
      ),
    );
  }

  /// Get bank logo image path based on scheme title
  String _getBankLogoPath(String title) {
    String? path;
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('hdfc')) {
      path = ImageConstant.imgHDFCBank;
    } else if (lowerTitle.contains('sbi')) {
      path = ImageConstant.imgSBIBank;
    } else if (lowerTitle.contains('icici')) {
      path = ImageConstant.imgICICIBank;
    } else if (lowerTitle.contains('axis')) {
      path = ImageConstant.imgAxisBank;
    } else if (lowerTitle.contains('mudra') || lowerTitle.contains('pradhan')) {
      path = ImageConstant.imgPradhanMantriMudra;
    } else if (lowerTitle.contains('bihar')) {
      path = ImageConstant.imgBiharLoan;
    } else if (lowerTitle.contains('up') ||
        lowerTitle.contains('uttar pradesh')) {
      path = ImageConstant.imgUPLoan;
    } else if (lowerTitle.contains('stand') ||
        lowerTitle.contains('stand-up')) {
      path = ImageConstant.imgStandUpIndia;
    } else if (lowerTitle.contains('msme') ||
        lowerTitle.contains('credit guarantee') ||
        lowerTitle.contains('psb') ||
        lowerTitle.contains('jan dhan') ||
        lowerTitle.contains('maharashtra')) {
      path = ImageConstant.imgMSMESchemes;
    } else {
      path = ImageConstant.imgPlaceholder;
    }
    return path;
  }

  /// Build carousel card
  Widget _buildCarouselCard(SchemeModel item, String itemId) {
    final isFavorite = _favorites.contains(itemId);
    final bankLogoPath = _getBankLogoPath(item.title);
    final cardHeight = 280.h;

    return GestureDetector(
      onTap: () => _onSchemeTap(item),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.h),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // White logo section at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: cardHeight * 0.45, // 45% for logo
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.h),
                    topRight: Radius.circular(24.h),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Image.asset(
                      bankLogoPath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.business,
                          size: 64.h,
                          color: appTheme.indigo_400,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Purple content section at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: cardHeight * 0.55, // 55% for content
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: appTheme.indigo_400,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.h),
                    bottomRight: Radius.circular(24.h),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w700,
                        color: appTheme.white_A700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.subtitle,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 14.fSize,
                        color: appTheme.white_A700.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Heart icon at top right
            Positioned(
              top: 16.h,
              right: 16.h,
              child: GestureDetector(
                onTap: () => _toggleFavorite(itemId),
                child: Container(
                  padding: EdgeInsets.all(6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 24.h,
                    color: Colors.pink.shade400,
                    fill: isFavorite ? 1.0 : 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build recommended card
  Widget _buildRecommendedCard(SchemeModel item, String itemId) {
    final isFavorite = _favorites.contains(itemId);
    final bankLogoPath = _getBankLogoPath(item.title);

    return GestureDetector(
      onTap: () => _onSchemeTap(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // White logo section at top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90.h, // Fixed height for logo section
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Image.asset(
                      bankLogoPath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.business,
                          size: 40.h,
                          color: appTheme.indigo_400,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Purple content section at bottom
            Positioned(
              top: 90.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: appTheme.indigo_400,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.h),
                    bottomRight: Radius.circular(20.h),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 14.fSize,
                        fontWeight: FontWeight.w600,
                        color: appTheme.white_A700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.subtitle,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 12.fSize,
                        color: appTheme.white_A700.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Heart icon at top right
            Positioned(
              top: 10.h,
              right: 10.h,
              child: GestureDetector(
                onTap: () => _toggleFavorite(itemId),
                child: Container(
                  padding: EdgeInsets.all(4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 18.h,
                    color: Colors.pink.shade400,
                    fill: isFavorite ? 1.0 : 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
