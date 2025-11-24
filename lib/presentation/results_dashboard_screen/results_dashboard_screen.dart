import 'package:circle_nav_bar/circle_nav_bar.dart';
import '../../core/app_export.dart';
import '../../core/models/dashboard_category_model.dart';

class ResultsDashboardScreen extends StatefulWidget {
  const ResultsDashboardScreen({super.key});

  @override
  State<ResultsDashboardScreen> createState() => _ResultsDashboardScreenState();
}

class _ResultsDashboardScreenState extends State<ResultsDashboardScreen> {
  final DataService _dataService = DataService();
  List<DashboardCategoryModel> _categories = [];
  bool _isLoading = true;
  int _currentNavIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final categories = await _dataService.loadDashboardCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
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
        Navigator.of(context).pushReplacementNamed(AppRoutes.discoverScreen);
        break;
      case 2:
        // Already on this screen
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(AppRoutes.profileScreen);
        break;
    }
  }

  IconData _getIconForCategory(String iconName) {
    switch (iconName) {
      case 'store':
        return Icons.store;
      case 'corporate_fare':
        return Icons.corporate_fare;
      case 'business':
        return Icons.business;
      default:
        return Icons.business_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            // Main Content
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: appTheme.indigo_400,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.h, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Investors Options',
                            style: TextStyleHelper
                                .instance.headline24BlackMerriweather
                                .copyWith(
                              fontSize: 28.fSize,
                              fontWeight: FontWeight.w900,
                              color: appTheme.whiteCustom,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          // Business sections
                          ..._categories.map((category) => Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: _buildBusinessSection(
                                  context,
                                  category: category,
                                  icon: _getIconForCategory(category.icon),
                                ),
                              )),
                          SizedBox(height: 80.h), // Space for bottom nav
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back arrow and profile icon
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 24.h,
                  color: appTheme.whiteCustom,
                ),
              ),
              SizedBox(width: 16.h),
              Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appTheme.cardDark,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 24.h,
                  color: appTheme.indigo_400,
                ),
              ),
            ],
          ),
          // Notification and settings icons
          Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                size: 24.h,
                color: appTheme.whiteCustom,
              ),
              SizedBox(width: 20.h),
              Icon(
                Icons.settings_outlined,
                size: 24.h,
                color: appTheme.whiteCustom,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessSection(
    BuildContext context, {
    required DashboardCategoryModel category,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and download icon
          Padding(
            padding: EdgeInsets.all(16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.h,
                      color: appTheme.indigo_400,
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      category.title,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w700,
                        color: appTheme.whiteCustom,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.download_outlined,
                  size: 24.h,
                  color: appTheme.indigo_400,
                ),
              ],
            ),
          ),
          // Placeholder graphics area
          Container(
            height: 120.h,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.black_800,
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlaceholderIcon(Icons.apartment, context),
                SizedBox(width: 24.h),
                _buildPlaceholderIcon(Icons.trending_up, context),
                SizedBox(width: 24.h),
                _buildPlaceholderIcon(Icons.account_balance, context),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Buttons row
          Padding(
            padding: EdgeInsets.all(16.h),
            child: Row(
              children: [
                // Apply Now button
                Expanded(
                  child: _buildApplyNowButton(context),
                ),
                SizedBox(width: 12.h),
                // See All button
                Expanded(
                  child: _buildSeeAllButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderIcon(IconData icon, BuildContext context) {
    return Container(
      width: 48.h,
      height: 48.h,
      decoration: BoxDecoration(
        color: appTheme.grey200,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 24.h,
        color: appTheme.grey_500,
      ),
    );
  }

  Widget _buildApplyNowButton(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: appTheme.backgroundDark,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.indigo_400,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Apply Now clicked'),
                duration: const Duration(seconds: 2),
                backgroundColor: appTheme.cardDark,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 18.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Apply Now',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w600,
                  color: appTheme.indigo_400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: appTheme.indigo_400,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('See All clicked'),
                duration: const Duration(seconds: 2),
                backgroundColor: appTheme.cardDark,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 18.h,
                color: appTheme.whiteCustom,
              ),
              SizedBox(width: 8.h),
              Text(
                'See All',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w600,
                  color: appTheme.whiteCustom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
