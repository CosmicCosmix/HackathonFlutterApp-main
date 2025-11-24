import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentNavIndex = 3;

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
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.findingBusinessesScreen);
        break;
      case 2:
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.resultsDashboardScreen);
        break;
      case 3:
        // Already on this screen
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 16.h),
                child: Column(
                  children: [
                    // Profile Card
                    _buildProfileCard(),
                    SizedBox(height: 24.h),
                    // Statistics Section
                    _buildStatisticsSection(),
                    SizedBox(height: 24.h),
                    // Investment Preferences
                    _buildInvestmentPreferencesSection(),
                    SizedBox(height: 24.h),
                    // Settings Section
                    _buildSettingsSection(),
                    SizedBox(height: 24.h),
                    // Logout Button
                    _buildLogoutButton(),
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
      decoration: BoxDecoration(
        color: appTheme.backgroundDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: TextStyleHelper.instance.headline24BlackMerriweather
                .copyWith(
              fontSize: 28.fSize,
              fontWeight: FontWeight.w900,
              color: appTheme.whiteCustom,
            ),
          ),
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

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: appTheme.indigo_400.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100.h,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  appTheme.indigo_400,
                  appTheme.indigo_500,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: appTheme.indigo_400.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 50.h,
                color: appTheme.whiteCustom,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Name
          Text(
            'Flow Fund User',
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: 24.fSize,
              fontWeight: FontWeight.w700,
              color: appTheme.whiteCustom,
            ),
          ),
          SizedBox(height: 8.h),
          // Email
          Text(
            'flowfunduser@email.com',
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: 14.fSize,
              color: appTheme.grey_500,
            ),
          ),
          SizedBox(height: 16.h),
          // Edit Profile Button
          Container(
            width: double.infinity,
            height: 44.h,
            decoration: BoxDecoration(
              color: appTheme.indigo_400.withOpacity(0.2),
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
                      content: Text('Edit Profile'),
                      backgroundColor: appTheme.cardDark,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.h),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 18.h,
                        color: appTheme.indigo_400,
                      ),
                      SizedBox(width: 8.h),
                      Text(
                        'Edit Profile',
                        style: TextStyleHelper.instance.bodyTextMerriweather
                            .copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w600,
                          color: appTheme.indigo_400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                size: 24.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              Text(
                'Investment Statistics',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 18.fSize,
                  fontWeight: FontWeight.w700,
                  color: appTheme.whiteCustom,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Investments',
                  '₹2,50,000',
                  Icons.account_balance_wallet,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: _buildStatCard(
                  'Active Deals',
                  '5',
                  Icons.business_center,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Avg. Return',
                  '12.5%',
                  Icons.show_chart,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: _buildStatCard(
                  'Match Score',
                  '87%',
                  Icons.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.black_800,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.indigo_400.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20.h,
            color: appTheme.indigo_400,
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: 20.fSize,
              fontWeight: FontWeight.w700,
              color: appTheme.whiteCustom,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
              fontSize: 12.fSize,
              color: appTheme.grey_500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentPreferencesSection() {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tune,
                size: 24.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              Text(
                'Investment Preferences',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 18.fSize,
                  fontWeight: FontWeight.w700,
                  color: appTheme.whiteCustom,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildPreferenceItem('Risk Appetite', 'Moderate', Icons.speed),
          SizedBox(height: 12.h),
          _buildPreferenceItem('Return Rate', '15-20%', Icons.trending_up),
          SizedBox(height: 12.h),
          _buildPreferenceItem('Diversification', 'Multiple', Icons.layers),
          SizedBox(height: 12.h),
          _buildPreferenceItem('Industry Focus', 'Tech, Retail', Icons.business),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.black_800,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: appTheme.indigo_400.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Icon(
              icon,
              size: 20.h,
              color: appTheme.indigo_400,
            ),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 14.fSize,
                    color: appTheme.grey_500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.w600,
                    color: appTheme.whiteCustom,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 20.h,
            color: appTheme.grey_500,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                size: 24.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              Text(
                'Settings',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 18.fSize,
                  fontWeight: FontWeight.w700,
                  color: appTheme.whiteCustom,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSettingItem('Notifications', Icons.notifications_outlined, () {}),
          SizedBox(height: 12.h),
          _buildSettingItem('Privacy & Security', Icons.lock_outline, () {}),
          SizedBox(height: 12.h),
          _buildSettingItem('Payment Methods', Icons.payment, () {}),
          SizedBox(height: 12.h),
          _buildSettingItem('Help & Support', Icons.help_outline, () {}),
          SizedBox(height: 12.h),
          _buildSettingItem('About', Icons.info_outline, () {}),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 14.h),
          decoration: BoxDecoration(
            color: appTheme.black_800,
            borderRadius: BorderRadius.circular(12.h),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Text(
                  label,
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 16.fSize,
                    color: appTheme.whiteCustom,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20.h,
                color: appTheme.grey_500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: appTheme.cardDark,
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(
          color: Colors.red.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: appTheme.cardDark,
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: appTheme.whiteCustom,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: appTheme.grey_400),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: appTheme.grey_500),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.businessFundingLandingScreen);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.h),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  size: 20.h,
                  color: Colors.red,
                ),
                SizedBox(width: 8.h),
                Text(
                  'Logout',
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 16.fSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

