import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class InvestmentPreferenceScreen extends StatefulWidget {
  InvestmentPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentPreferenceScreen> createState() =>
      _InvestmentPreferenceScreenState();
}

class _InvestmentPreferenceScreenState
    extends State<InvestmentPreferenceScreen> {
  double _riskAppetite =
      0.0; // 0.0 = Conservative, 0.5 = Moderate, 1.0 = Aggressive
  double _preferredReturnRate = 0.0; // 0.0 = 10-15%, 0.5 = 15-20%, 1.0 = 20%+
  String? _diversification; // 'single' or 'multiple'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black_900,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: CustomImageView(
              imagePath: ImageConstant.imgFantasyBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Dark content card
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              decoration: BoxDecoration(
                color: appTheme.black_800,
                borderRadius: BorderRadius.circular(24.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back arrow and title
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.h,
                      top: 24.h,
                      right: 24.h,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.h,
                            color: appTheme.white_A700,
                          ),
                        ),
                        SizedBox(width: 12.h),
                        Text(
                          'Detailed Profile',
                          style: TextStyleHelper
                              .instance.headline24BlackMerriweather
                              .copyWith(
                            fontSize: 18.fSize,
                            fontWeight: FontWeight.w700,
                            color: appTheme.whiteCustom,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Main title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Text(
                      'Investment Preference (1/2)',
                      style: TextStyleHelper
                          .instance.headline24BlackMerriweather
                          .copyWith(
                        fontSize: 20.fSize,
                        color: appTheme.whiteCustom,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Content scrollable area
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Risk Appetite section
                          _buildRiskAppetiteSection(),
                          SizedBox(height: 40.h),
                          // Preferred Return Rate section
                          _buildPreferredReturnRateSection(),
                          SizedBox(height: 40.h),
                          // Diversification section
                          _buildDiversificationSection(),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  // Bottom navigation
                  Padding(
                    padding: EdgeInsets.all(24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Skip for now',
                            style: TextStyleHelper.instance.bodyTextMerriweather
                                .copyWith(
                              fontSize: 16.fSize,
                              color: appTheme.indigo_400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        CustomButton(
                          text: 'Next',
                          width: 120.h,
                          height: 50.h,
                          backgroundColor: appTheme.indigo_400,
                          textColor: appTheme.whiteCustom,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w400,
                          borderRadius: BorderRadius.circular(24.h),
                          onPressed: () {
                            _onNextPressed(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAppetiteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Appetite',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.grey_400,
          ),
        ),
        SizedBox(height: 16.h),
        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.h),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.h),
            activeTrackColor: appTheme.indigo_400,
            inactiveTrackColor: appTheme.deep_purple_100,
            thumbColor: appTheme.whiteCustom,
            overlayColor: appTheme.indigo_400.withOpacity(0.2),
          ),
          child: Slider(
            value: _riskAppetite,
            onChanged: (value) {
              setState(() {
                _riskAppetite = value;
              });
            },
            min: 0.0,
            max: 1.0,
          ),
        ),
        SizedBox(height: 8.h),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Conservative',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _riskAppetite < 0.3
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
            Text(
              'Moderate',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _riskAppetite >= 0.3 && _riskAppetite < 0.7
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
            Text(
              'Aggressive',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _riskAppetite >= 0.7
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreferredReturnRateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Return Rate',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.grey_400,
          ),
        ),
        SizedBox(height: 16.h),
        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.h),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.h),
            activeTrackColor: appTheme.indigo_400,
            inactiveTrackColor: appTheme.deep_purple_100,
            thumbColor: appTheme.whiteCustom,
            overlayColor: appTheme.indigo_400.withOpacity(0.2),
          ),
          child: Slider(
            value: _preferredReturnRate,
            onChanged: (value) {
              setState(() {
                _preferredReturnRate = value;
              });
            },
            min: 0.0,
            max: 1.0,
          ),
        ),
        SizedBox(height: 8.h),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '10-15%',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _preferredReturnRate < 0.3
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
            Text(
              '15-20%',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _preferredReturnRate >= 0.3 && _preferredReturnRate < 0.7
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
            Text(
              '20%+',
              style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                fontSize: 14.fSize,
                color: _preferredReturnRate >= 0.7
                    ? appTheme.whiteCustom
                    : appTheme.grey_500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDiversificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diversification',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.grey_400,
          ),
        ),
        SizedBox(height: 16.h),
        // Single business option
        GestureDetector(
          onTap: () {
            setState(() {
              _diversification = 'single';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'single',
                groupValue: _diversification,
                onChanged: (value) {
                  setState(() {
                    _diversification = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Single business',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: _diversification == 'single'
                      ? appTheme.whiteCustom
                      : appTheme.grey_500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Multiple businesses option
        GestureDetector(
          onTap: () {
            setState(() {
              _diversification = 'multiple';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'multiple',
                groupValue: _diversification,
                onChanged: (value) {
                  setState(() {
                    _diversification = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Multiple businesses',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: _diversification == 'multiple'
                      ? appTheme.whiteCustom
                      : appTheme.grey_500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onNextPressed(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.investorDetailsScreen);
  }
}
