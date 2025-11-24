import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class InvestorDetailsScreen extends StatefulWidget {
  InvestorDetailsScreen({Key? key}) : super(key: key);

  @override
  State<InvestorDetailsScreen> createState() => _InvestorDetailsScreenState();
}

class _InvestorDetailsScreenState extends State<InvestorDetailsScreen> {
  String? _investorType; // 'individual' or 'business'
  String? _investmentExperience; // 'first_time', 'some_experience', or 'expert'
  late TextEditingController _contactNumberController;

  @override
  void initState() {
    super.initState();
    _contactNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _contactNumberController.dispose();
    super.dispose();
  }

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
                      'Investor Details (2/2)',
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
                          // Investor Type section
                          _buildInvestorTypeSection(),
                          SizedBox(height: 40.h),
                          // Investment Experience section
                          _buildInvestmentExperienceSection(),
                          SizedBox(height: 40.h),
                          // Contact number section
                          _buildContactNumberSection(),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  // Bottom button
                  Padding(
                    padding: EdgeInsets.all(24.h),
                    child: CustomButton(
                      text: 'Unlock all opportunities',
                      width: double.infinity,
                      height: 50.h,
                      backgroundColor: appTheme.indigo_400,
                      textColor: appTheme.whiteCustom,
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w400,
                      borderRadius: BorderRadius.circular(24.h),
                      onPressed: () {
                        _onUnlockOpportunitiesPressed(context);
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

  Widget _buildInvestorTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investor Type',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 16.h),
        // Individual option
        GestureDetector(
          onTap: () {
            setState(() {
              _investorType = 'individual';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'individual',
                groupValue: _investorType,
                onChanged: (value) {
                  setState(() {
                    _investorType = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Individual',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: appTheme.white_A700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Business/Corporate option
        GestureDetector(
          onTap: () {
            setState(() {
              _investorType = 'business';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'business',
                groupValue: _investorType,
                onChanged: (value) {
                  setState(() {
                    _investorType = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Business/Corporate',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: appTheme.white_A700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investment Experience',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 16.h),
        // First time option
        GestureDetector(
          onTap: () {
            setState(() {
              _investmentExperience = 'first_time';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'first_time',
                groupValue: _investmentExperience,
                onChanged: (value) {
                  setState(() {
                    _investmentExperience = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'First time',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: appTheme.white_A700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Some experience option
        GestureDetector(
          onTap: () {
            setState(() {
              _investmentExperience = 'some_experience';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'some_experience',
                groupValue: _investmentExperience,
                onChanged: (value) {
                  setState(() {
                    _investmentExperience = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Some experience',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: appTheme.white_A700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Expert option
        GestureDetector(
          onTap: () {
            setState(() {
              _investmentExperience = 'expert';
            });
          },
          child: Row(
            children: [
              Radio<String>(
                value: 'expert',
                groupValue: _investmentExperience,
                onChanged: (value) {
                  setState(() {
                    _investmentExperience = value;
                  });
                },
                activeColor: appTheme.indigo_400,
              ),
              SizedBox(width: 8.h),
              Text(
                'Expert',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  fontSize: 16.fSize,
                  color: appTheme.white_A700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact number',
          style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
            color: appTheme.white_A700,
          ),
        ),
        SizedBox(height: 16.h),
        // Phone number input field
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
              // Left arrow icon
              Icon(
                Icons.arrow_back_ios,
                size: 16.h,
                color: appTheme.indigo_400,
              ),
              SizedBox(width: 12.h),
              // Text input
              Expanded(
                child: TextField(
                  controller: _contactNumberController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone number',
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
              // Clear button (X icon) - show when there's text
              if (_contactNumberController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _contactNumberController.clear();
                    });
                  },
                  child: Icon(
                    Icons.close,
                    size: 20.h,
                    color: appTheme.deep_purple_300,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _onUnlockOpportunitiesPressed(BuildContext context) {
    // Navigate to Results Dashboard screen
    Navigator.of(context).pushNamed(AppRoutes.resultsDashboardScreen);
  }
}
