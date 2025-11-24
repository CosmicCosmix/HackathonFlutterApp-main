import 'package:flutter/services.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class QuickProfileScreen extends StatefulWidget {
  const QuickProfileScreen({super.key});

  @override
  State<QuickProfileScreen> createState() => _QuickProfileScreenState();
}

class _QuickProfileScreenState extends State<QuickProfileScreen> {
  // 0.0 to 1.0; mapped to 0–10 Cr in 0.5 Cr steps
  double _investmentBudget = 0.0;
  final String _preferredIndustry = 'Retail';
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  /// Map slider value (0.0–1.0) to 0–10 Cr in 0.5 Cr steps and format as text
  String _formatInvestmentBudget(double sliderValue) {
    // 0.0–1.0 → 0–20 → /2 = 0.0, 0.5, 1.0, ... 10.0
    double crore = (sliderValue * 20).round() / 2;

    if (crore == 0) {
      return '0';
    }

    if (crore == crore.roundToDouble()) {
      return '${crore.toInt()} Cr';
    } else {
      return '${crore.toStringAsFixed(1)} Cr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
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
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
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
                          'Quick Profile',
                          style: TextStyleHelper
                              .instance.headline24BlackMerriweather
                              .copyWith(
                            fontSize: 20.fSize,
                            fontWeight: FontWeight.w700,
                            color: appTheme.whiteCustom,
                          ),
                        ),
                      ],
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
                          // Investment Budget section
                          _buildInvestmentBudgetSection(),
                          SizedBox(height: 32.h),
                          // Preferred Industry section
                          _buildPreferredIndustrySection(),
                          SizedBox(height: 32.h),
                          // Location section
                          _buildLocationSection(),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  // Bottom button
                  Padding(
                    padding: EdgeInsets.all(24.h),
                    child: CustomButton(
                      text: 'Show Investment Opportunities',
                      width: double.infinity,
                      height: 50.h,
                      backgroundColor: appTheme.indigo_400,
                      textColor: appTheme.whiteCustom,
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w400,
                      borderRadius: BorderRadius.circular(24.h),
                      onPressed: () {
                        _onShowOpportunitiesPressed(context);
                      },
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

  Widget _buildInvestmentBudgetSection() {
    final String budgetLabel = _formatInvestmentBudget(_investmentBudget);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investment Budget',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 8.h),
        // Visible numeric text (0, 1 Cr, 1.5 Cr, ..., 10 Cr)
        Text(
          budgetLabel,
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            color: appTheme.whiteCustom,
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
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            value: _investmentBudget,
            onChanged: (value) {
              setState(() {
                _investmentBudget = value;
              });
            },
            min: 0.0,
            max: 1.0,
            divisions: 20, // 0.5 Cr steps from 0 to 10 Cr
            label: budgetLabel, // value indicator label
          ),
        ),
      ],
    );
  }

  Widget _buildPreferredIndustrySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Industry',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 16.h),
        // Industry selector field
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: appTheme.black_700,
            borderRadius: BorderRadius.circular(28.h),
            border: Border.all(color: appTheme.black_600),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            children: [
              Icon(
                Icons.arrow_forward_ios,
                size: 16.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              Container(
                width: 24.h,
                height: 24.h,
                decoration: BoxDecoration(
                  color: appTheme.black_600,
                  borderRadius: BorderRadius.circular(4.h),
                ),
                child: Icon(
                  Icons.business,
                  size: 16.h,
                  color: appTheme.white_A700.withOpacity(0.5),
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Text(
                  _preferredIndustry,
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    fontSize: 16.fSize,
                    color: appTheme.white_A700,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 24.h,
                color: appTheme.indigo_400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 16.h),
        // Location input field
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: appTheme.black_700,
            borderRadius: BorderRadius.circular(28.h),
            border: Border.all(color: appTheme.black_600),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Preferred location',
                    hintStyle:
                    TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                      color: appTheme.grey_500,
                      fontSize: 16.fSize,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    color: appTheme.whiteCustom,
                    fontSize: 16.fSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onShowOpportunitiesPressed(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.findingBusinessesScreen);
  }
}