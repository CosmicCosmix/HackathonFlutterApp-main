import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

class QuickProfileSetupScreen extends StatefulWidget {
  const QuickProfileSetupScreen({super.key});

  @override
  State<QuickProfileSetupScreen> createState() =>
      _QuickProfileSetupScreenState();
}

class _QuickProfileSetupScreenState extends State<QuickProfileSetupScreen> {
  String? _selectedBusinessType;
  late TextEditingController _locationController;
  double _annualTurnover = 0.5; // Value between 0.0 and 1.0

  final List<String> _businessTypes = [
    'Retail',
    'Technology',
    'Manufacturing',
    'Services',
    'Healthcare',
    'Finance',
    'Education',
    'Real Estate',
  ];

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
  String _formatTurnover(double sliderValue) {
    // 0.0–1.0 → 0–20 → /2 = 0.0, 0.5, 1.0, ... 10.0
    double crore = (sliderValue * 20).round() / 2;

    if (crore == 0) {
      return 'Annual Turnover (slider)';
    }

    if (crore == crore.roundToDouble()) {
      return '${crore.toInt()} Cr Annual Turnover';
    } else {
      return '${crore.toStringAsFixed(1)} Cr Annual Turnover';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          // Fantasy background image
          Positioned.fill(
            child: CustomImageView(
              imagePath: ImageConstant.imgFantasyBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Dark content overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.black_800,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.h),
                  topRight: Radius.circular(36.h),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 28.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Profile title
                  Text(
                    'Quick Profile',
                    style: TextStyleHelper.instance.headline24BlackMerriweather
                        .copyWith(
                      height: 31 / 24,
                      color: appTheme.whiteCustom,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Business Type dropdown field
                  _buildBusinessTypeField(),
                  SizedBox(height: 20.h),
                  // Location field
                  _buildLocationField(),
                  SizedBox(height: 20.h),
                  // Annual Turnover slider field
                  _buildAnnualTurnoverField(),
                  SizedBox(height: 40.h),
                  // Show My Matches button
                  Center(
                    child: CustomButton(
                      text: 'Show My Matches',
                      width: 198.h,
                      height: 50.h,
                      backgroundColor: appTheme.indigo_400,
                      textColor: appTheme.white_A700,
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w900,
                      borderRadius: BorderRadius.circular(24.h),
                      padding: EdgeInsets.all(12.h),
                      onPressed: () => _onShowMyMatchesPressed(context),
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

  /// Business Type dropdown field
  Widget _buildBusinessTypeField() {
    return GestureDetector(
      onTap: () {
        _showBusinessTypeDropdown();
      },
      child: Container(
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
            // Text
            Expanded(
              child: Text(
                _selectedBusinessType ?? 'Business Type (dropdown)|',
                style: TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                  color: appTheme.white_A700,
                  fontSize: 16.fSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Dropdown icon
            Icon(
              Icons.keyboard_arrow_down,
              size: 24.h,
              color: appTheme.indigo_400,
            ),
          ],
        ),
      ),
    );
  }

  /// Location field
  Widget _buildLocationField() {
    return Container(
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
              controller: _locationController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Location|',
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
          // Clear button (X icon)
          if (_locationController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                setState(() {
                  _locationController.clear();
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
    );
  }

  /// Annual Turnover slider field
  Widget _buildAnnualTurnoverField() {
    final String turnoverLabel = _formatTurnover(_annualTurnover);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: appTheme.deep_purple_100,
            borderRadius: BorderRadius.circular(28.h),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            children: [
              // Left arrow icon
              Icon(
                Icons.arrow_back_ios,
                size: 16.h,
                color: appTheme.deep_purple_300,
              ),
              SizedBox(width: 12.h),
              // Dynamic text
              Expanded(
                child: Text(
                  turnoverLabel,
                  style:
                  TextStyleHelper.instance.bodyTextMerriweather.copyWith(
                    color: appTheme.whiteCustom,
                    fontSize: 16.fSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Clear button (X icon)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _annualTurnover = 0.5;
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
        SizedBox(height: 16.h),
        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.h),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16.h),
            activeTrackColor: appTheme.indigo_400,
            inactiveTrackColor: appTheme.deep_purple_100,
            thumbColor: appTheme.white_A700,
            overlayColor: appTheme.indigo_400.withOpacity(0.2),
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            value: _annualTurnover,
            onChanged: (value) {
              setState(() {
                _annualTurnover = value;
              });
            },
            min: 0.0,
            max: 1.0,
            divisions: 20, // 0, 0.05, ... 1.0 → 0–10 Cr in 0.5 steps
            label: turnoverLabel,
          ),
        ),
      ],
    );
  }

  /// Show business type dropdown
  void _showBusinessTypeDropdown() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: appTheme.white_A700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.h),
              topRight: Radius.circular(24.h),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.h,
                height: 4.h,
                decoration: BoxDecoration(
                  color: appTheme.blue_gray_100,
                  borderRadius: BorderRadius.circular(2.h),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _businessTypes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _businessTypes[index],
                      style: TextStyleHelper.instance.bodyTextMerriweather
                          .copyWith(
                        fontSize: 16.fSize,
                        color: appTheme.black_900,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedBusinessType = _businessTypes[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  /// Handles the "Show My Matches" button press
  void _onShowMyMatchesPressed(BuildContext context) {
    // Navigate to initial results teaser screen
    Navigator.of(context).pushNamed(AppRoutes.initialResultsTeaserScreen);
  }
}