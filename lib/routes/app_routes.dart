import 'package:flutter/material.dart';
import '../presentation/business_funding_landing_screen/business_funding_landing_screen.dart';
import '../presentation/quick_profile_setup_screen/quick_profile_setup_screen.dart';
import '../presentation/discover_screen/discover_screen.dart';
import '../presentation/initial_results_teaser_screen/initial_results_teaser_screen.dart';
import '../presentation/investment_preference_screen/investment_preference_screen.dart';
import '../presentation/investor_details_screen/investor_details_screen.dart';
import '../presentation/results_dashboard_screen/results_dashboard_screen.dart';
import '../presentation/quick_profile_screen/quick_profile_screen.dart';
import '../presentation/finding_businesses_screen/finding_businesses_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';

class AppRoutes {
  static const String businessFundingLandingScreen =
      '/business_funding_landing_screen';
  static const String quickProfileSetupScreen = '/quick_profile_setup_screen';
  static const String discoverScreen = '/discover_screen';
  static const String initialResultsTeaserScreen =
      '/initial_results_teaser_screen';
  static const String investmentPreferenceScreen =
      '/investment_preference_screen';
  static const String investorDetailsScreen = '/investor_details_screen';
  static const String resultsDashboardScreen = '/results_dashboard_screen';
  static const String quickProfileScreen = '/quick_profile_screen';
  static const String findingBusinessesScreen = '/finding_businesses_screen';
  static const String profileScreen = '/profile_screen';

  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        businessFundingLandingScreen: (context) =>
            BusinessFundingLandingScreen(),
        quickProfileSetupScreen: (context) => QuickProfileSetupScreen(),
        discoverScreen: (context) => DiscoverScreen(),
        initialResultsTeaserScreen: (context) => InitialResultsTeaserScreen(),
        investmentPreferenceScreen: (context) => InvestmentPreferenceScreen(),
        investorDetailsScreen: (context) => InvestorDetailsScreen(),
        resultsDashboardScreen: (context) => ResultsDashboardScreen(),
        quickProfileScreen: (context) => QuickProfileScreen(),
        findingBusinessesScreen: (context) => FindingBusinessesScreen(),
        profileScreen: (context) => ProfileScreen(),
        initialRoute: (context) => BusinessFundingLandingScreen()
      };
}
