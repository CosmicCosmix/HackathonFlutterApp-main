import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../quick_profile_setup_screen/quick_profile_setup_screen.dart';

class BusinessFundingLandingScreen extends StatelessWidget {
  const BusinessFundingLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black_900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 480.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle19,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(1.h),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 24.h,
                      left: 7.h,
                      right: 7.h,
                    ),
                    child: CustomButton(
                      text: 'Investor Login',
                      width: double.infinity,
                      height: 50.h,
                      backgroundColor: appTheme.indigo_400,
                      textColor: appTheme.whiteCustom,
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w400,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.h,
                        vertical: 12.h,
                      ),
                      onPressed: () {
                        _onInvestorLoginTap(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(
              top: 30.h,
              left: 36.h,
            ),
            child: Text(
              'Get Funding For Your Business In Minutes.',
              style: TextStyleHelper.instance.display36BoldMerriweather
                  .copyWith(height: 1.25),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.h),
            alignment: Alignment.centerRight,
            child: CustomButton(
              text: 'Find My Funding',
              width: 258.h,
              height: 62.h,
              backgroundColor: appTheme.deep_purple_300,
              textColor: appTheme.whiteCustom,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w400,
              leftIcon: ImageConstant.imgGroup8,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.h),
                bottomLeft: Radius.circular(24.h),
              ),
              padding: EdgeInsets.fromLTRB(20.h, 18.h, 20.h, 18.h),
              onPressed: () {
                _onFindMyFundingTap(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 18.h,
              bottom: 20.h,
            ),
            alignment: Alignment.centerLeft,
            child: CustomButton(
              text: 'Explore All Schemes',
              width: 270.h,
              height: 62.h,
              backgroundColor: appTheme.indigo_400,
              textColor: appTheme.whiteCustom,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w400,
              rightIcon: ImageConstant.imgGroup7,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.h),
                bottomRight: Radius.circular(24.h),
              ),
              padding: EdgeInsets.fromLTRB(20.h, 18.h, 20.h, 18.h),
              onPressed: () {
                _onExploreAllSchemesTap(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onInvestorLoginTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.quickProfileScreen);
  }

  void _onFindMyFundingTap(BuildContext context) {
    // Navigate to quick profile setup screen as bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => QuickProfileSetupScreen(),
    );
  }

  void _onExploreAllSchemesTap(BuildContext context) {
    // Navigate to discover screen
    Navigator.of(context).pushNamed(AppRoutes.discoverScreen);
  }
}
