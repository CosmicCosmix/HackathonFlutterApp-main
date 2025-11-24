import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import '../../core/app_export.dart';
import '../../core/models/match_model.dart';
import '../../core/services/data_service.dart';
import '../../widgets/custom_button.dart';

class InitialResultsTeaserScreen extends StatefulWidget {
  InitialResultsTeaserScreen({Key? key}) : super(key: key);

  @override
  State<InitialResultsTeaserScreen> createState() =>
      _InitialResultsTeaserScreenState();
}

class _InitialResultsTeaserScreenState
    extends State<InitialResultsTeaserScreen> {
  int _currentNavIndex = 0;
  Set<String> _favorites = {};
  List<MatchModel> _matchItems = [];
  bool _isLoading = true;
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final matches = await _dataService.loadMatches();
      setState(() {
        _matchItems = matches;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading matches: $e');
      setState(() {
        _isLoading = false;
      });
    }
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

  void _onMatchTap(MatchModel match) {
    // Handle match tap - can navigate to detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${match.title} selected - Match Score: ${match.matchScore}'),
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
        Navigator.of(context).pushReplacementNamed(AppRoutes.discoverScreen);
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
              decoration: BoxDecoration(
                color: appTheme.black_800,
              ),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  // Header icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Profile icon
                      Container(
                        width: 40.h,
                        height: 40.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appTheme.black_700,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 24.h,
                          color: appTheme.indigo_400,
                        ),
                      ),
                      // Bell and gear icons
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            size: 24.h,
                            color: appTheme.white_A700,
                          ),
                          SizedBox(width: 20.h),
                          Icon(
                            Icons.settings_outlined,
                            size: 24.h,
                            color: appTheme.white_A700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title/Message
                    Center(
                      child: Text(
                        'Analyzing... Found 47 matches!',
                        style: TextStyleHelper
                            .instance.headline24BlackMerriweather
                            .copyWith(
                          fontSize: 24.fSize,
                          fontWeight: FontWeight.w700,
                          color: appTheme.white_A700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Match Cards
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: appTheme.indigo_400,
                            ),
                          )
                        : _matchItems.isEmpty
                            ? Center(
                                child: Text(
                                  'No matches found',
                                  style: TextStyleHelper
                                      .instance.bodyTextMerriweather,
                                ),
                              )
                            : _buildMatchCards(),
                    SizedBox(height: 40.h),
                    // Show My Matches button
                    Center(
                      child: CustomButton(
                        text: 'Show My Matches',
                        width: 280.h,
                        height: 56.h,
                        backgroundColor: appTheme.indigo_400,
                        textColor: appTheme.white_A700,
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w700,
                        borderRadius: BorderRadius.circular(28.h),
                        padding: EdgeInsets.all(16.h),
                        onPressed: () => _onShowMyMatchesPressed(context),
                      ),
                    ),
                  ],
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

  /// Build match cards
  Widget _buildMatchCards() {
    if (_matchItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        // First large card
        if (_matchItems.length > 0)
          _buildMatchCard(_matchItems[0], 0, isLarge: true),
        SizedBox(height: 20.h),
        // Two smaller cards side by side
        if (_matchItems.length > 2)
          Row(
            children: [
              Expanded(
                child: _buildMatchCard(_matchItems[1], 1),
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: _buildMatchCard(_matchItems[2], 2),
              ),
            ],
          ),
        if (_matchItems.length > 2) SizedBox(height: 20.h),
        // Another large card
        if (_matchItems.length > 3)
          _buildMatchCard(_matchItems[3], 3, isLarge: true),
        if (_matchItems.length > 3) SizedBox(height: 20.h),
        // One more card
        if (_matchItems.length > 4) _buildMatchCard(_matchItems[4], 4),
      ],
    );
  }

  /// Get bank logo image path based on loan title
  String _getBankLogoPath(String title) {
    String? path;
    if (title.toLowerCase().contains('hdfc')) {
      path = ImageConstant.imgHDFCBank;
    } else if (title.toLowerCase().contains('sbi')) {
      path = ImageConstant.imgSBIBank;
    } else if (title.toLowerCase().contains('icici')) {
      path = ImageConstant.imgICICIBank;
    } else if (title.toLowerCase().contains('axis')) {
      path = ImageConstant.imgAxisBank;
    } else if (title.toLowerCase().contains('mudra') ||
        title.toLowerCase().contains('pradhan')) {
      path = ImageConstant.imgPradhanMantriMudra;
    } else {
      path = ImageConstant.imgPlaceholder;
    }
    print('Bank logo path for "$title": $path');
    return path;
  }

  /// Build individual match card
  Widget _buildMatchCard(MatchModel item, int index, {bool isLarge = false}) {
    final itemId = 'match_${item.id}';
    final isFavorite = _favorites.contains(itemId);
    final cardHeight = isLarge ? 200.h : 160.h;
    final bankLogoPath = _getBankLogoPath(item.title);

    return GestureDetector(
      onTap: () => _onMatchTap(item),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
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
                height: cardHeight * 0.4, // 40% of card for logo
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.h),
                    topRight: Radius.circular(16.h),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Image.asset(
                      bankLogoPath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $bankLogoPath - $error');
                        return Icon(
                          Icons.account_balance,
                          size: isLarge ? 48.h : 40.h,
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
                height: cardHeight * 0.6, // 60% of card for content
                padding:
                    EdgeInsets.all(10.h), // Reduced from 12.h to fix overflow
                decoration: BoxDecoration(
                  color: appTheme.indigo_400,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.h),
                    bottomRight: Radius.circular(16.h),
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
                        fontSize: isLarge ? 18.fSize : 16.fSize,
                        fontWeight: FontWeight.w700,
                        color: appTheme.white_A700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h), // Reduced from 3.h
                    Text(
                      item.subtitle,
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: isLarge ? 14.fSize : 12.fSize,
                        color: appTheme.white_A700.withOpacity(0.9),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isLarge) ...[
                      SizedBox(height: 5.h), // Reduced from 6.h
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 2.h), // Reduced vertical from 3.h
                        decoration: BoxDecoration(
                          color: appTheme.white_A700.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        child: Text(
                          'Match Score: ${item.matchScore}',
                          style: TextStyleHelper.instance.bodyTextMerriweather
                              .copyWith(
                            fontSize: 12.fSize,
                            fontWeight: FontWeight.w600,
                            color: appTheme.white_A700,
                          ),
                        ),
                      ),
                    ],
                    if (isLarge && item.highlights.isNotEmpty) ...[
                      SizedBox(height: 5.h), // Reduced from 6.h
                      Wrap(
                        spacing: 4.h,
                        runSpacing: 4.h,
                        children: item.highlights
                            .take(3)
                            .map((highlight) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.h, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color:
                                        appTheme.white_A700.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(6.h),
                                  ),
                                  child: Text(
                                    highlight,
                                    style: TextStyleHelper
                                        .instance.bodyTextMerriweather
                                        .copyWith(
                                      fontSize: 10.fSize,
                                      color:
                                          appTheme.white_A700.withOpacity(0.9),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Heart icon at top right
            Positioned(
              top: 12.h,
              right: 12.h,
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
                    size: isLarge ? 22.h : 20.h,
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

  /// Handle Show My Matches button press
  void _onShowMyMatchesPressed(BuildContext context) {
    // Navigate to detailed matches screen or show all matches
    if (_matchItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No matches available'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Showing ${_matchItems.length} matches'),
          duration: Duration(seconds: 2),
        ),
      );
      // This can be updated when the detailed matches screen is created
      // Navigator.of(context).pushNamed(AppRoutes.detailedMatchesScreen);
    }
  }
}
