import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import '../../core/app_export.dart';
import '../../core/models/business_model.dart';
import '../../core/services/data_service.dart';

class FindingBusinessesScreen extends StatefulWidget {
  const FindingBusinessesScreen({Key? key}) : super(key: key);

  @override
  State<FindingBusinessesScreen> createState() =>
      _FindingBusinessesScreenState();
}

class _FindingBusinessesScreenState extends State<FindingBusinessesScreen> {
  final DataService _dataService = DataService();
  List<BusinessModel> _businesses = [];
  bool _isLoading = true;
  int _currentNavIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadBusinesses();
  }

  Future<void> _loadBusinesses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final businesses = await _dataService.loadFindingBusinesses();
      setState(() {
        _businesses = businesses;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading businesses: $e');
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
        // Already on this screen
        break;
      case 2:
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.resultsDashboardScreen);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(AppRoutes.profileScreen);
        break;
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
                        children: [
                          if (_businesses.length > 0)
                            _buildBusinessCard(_businesses[0],
                                isFullWidth: true),
                          if (_businesses.length > 0) SizedBox(height: 20.h),
                          // Two Side-by-Side Placeholder Cards
                          if (_businesses.length > 1)
                            Row(
                              children: [
                                Expanded(
                                  child: _businesses.length > 1
                                      ? _buildBusinessCard(_businesses[1],
                                          isFullWidth: false)
                                      : _buildPlaceholderCard(),
                                ),
                                SizedBox(width: 16.h),
                                Expanded(
                                  child: _businesses.length > 2
                                      ? _buildBusinessCard(_businesses[2],
                                          isFullWidth: false)
                                      : _buildPlaceholderCard(),
                                ),
                              ],
                            ),
                          if (_businesses.length > 1) SizedBox(height: 20.h),
                          // Additional businesses
                          if (_businesses.length > 3)
                            ..._businesses.skip(3).map((business) => Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: _buildBusinessCard(business,
                                      isFullWidth: true),
                                )),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
            ),
            // Complete Profile Button - Fixed above bottom nav
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
              decoration: BoxDecoration(
                color: appTheme.backgroundDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: _buildCompleteProfileButton(context),
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
      decoration: BoxDecoration(
        color: appTheme.backgroundDark,
      ),
      child: Column(
        children: [
          // Top row with profile icon and notification/settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile icon
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
          SizedBox(height: 16.h),
          // Title and back arrow
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 20.h,
                  color: appTheme.whiteCustom,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Text(
                  'Finding businesses for you...',
                  style: TextStyleHelper.instance.headline24BlackMerriweather
                      .copyWith(
                    fontSize: 24.fSize,
                    fontWeight: FontWeight.w900,
                    color: appTheme.whiteCustom,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(BusinessModel business,
      {required bool isFullWidth}) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        border: Border.all(
          color: appTheme.indigo_400.withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: isFullWidth
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        style: TextStyleHelper.instance.bodyTextMerriweather
                            .copyWith(
                          fontSize: 18.fSize,
                          fontWeight: FontWeight.w700,
                          color: appTheme.whiteCustom,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow('Funding Needed: ', business.fundingNeeded,
                          isLabel: true),
                      SizedBox(height: 4.h),
                      _buildInfoRow('Expected Return: ', business.expectedReturn,
                          isLabel: true),
                      SizedBox(height: 4.h),
                      _buildInfoRow('Match: ', '${business.matchPercentage}% fit',
                          isLabel: true, isMatch: true),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Viewing details for ${business.name}'),
                              duration: Duration(seconds: 2),
                              backgroundColor: appTheme.cardDark,
                            ),
                          );
                        },
                        child: Text(
                          'click to view details',
                          style: TextStyleHelper.instance.bodyTextMerriweather
                              .copyWith(
                            fontSize: 14.fSize,
                            color: appTheme.indigo_400,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                // Right side - Placeholder icons
                _buildPlaceholderIcons(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  business.name,
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.w700,
                    color: appTheme.whiteCustom,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                _buildInfoRow('Funding: ', business.fundingNeeded, isLabel: false),
                SizedBox(height: 3.h),
                _buildInfoRow('Return: ', business.expectedReturn, isLabel: false),
                SizedBox(height: 3.h),
                _buildInfoRow('Match: ', '${business.matchPercentage}%',
                    isLabel: false, isMatch: true),
                SizedBox(height: 6.h),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing details for ${business.name}'),
                        duration: Duration(seconds: 2),
                        backgroundColor: appTheme.cardDark,
                      ),
                    );
                  },
                  child: Text(
                    'click to view details',
                    style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                      fontSize: 12.fSize,
                      color: appTheme.indigo_400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {required bool isLabel, bool isMatch = false}) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: isLabel ? 14.fSize : 12.fSize,
              color: appTheme.grey_500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: isLabel ? 14.fSize : 12.fSize,
              fontWeight: FontWeight.w600,
              color: isMatch ? appTheme.indigo_400 : appTheme.whiteCustom,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderCard() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        border: Border.all(
          color: appTheme.indigo_400.withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: _buildPlaceholderIcons(),
    );
  }

  Widget _buildPlaceholderIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPlaceholderShape(Icons.change_history, 0), // Triangle
        SizedBox(width: 12.h),
        _buildPlaceholderShape(Icons.star, 1), // Starburst
        SizedBox(width: 12.h),
        _buildPlaceholderShape(Icons.crop_square, 2), // Rounded square
      ],
    );
  }

  Widget _buildPlaceholderShape(IconData icon, int index) {
    IconData shapeIcon;
    if (index == 0) {
      shapeIcon = Icons.change_history; // Triangle
    } else if (index == 1) {
      shapeIcon = Icons.star; // Starburst
    } else {
      shapeIcon = Icons.crop_square; // Square
    }

    return Container(
      width: 32.h,
      height: 32.h,
      decoration: BoxDecoration(
        color: appTheme.grey200,
        shape: index == 2 ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: index == 2 ? BorderRadius.circular(4.h) : null,
      ),
      child: Icon(
        shapeIcon,
        size: 18.h,
        color: appTheme.grey_500,
      ),
    );
  }

  Widget _buildCompleteProfileButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: appTheme.indigo_400,
        borderRadius: BorderRadius.circular(24.h),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.investmentPreferenceScreen);
          },
          borderRadius: BorderRadius.circular(24.h),
          child: Center(
            child: Text(
              'Complete Profile',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 16.fSize,
                fontWeight: FontWeight.w600,
                color: appTheme.whiteCustom,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
