import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../widgets/app_image.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  static const _shortText =
      'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros '
      'laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet '
      'tellus...';
  static const _fullText =
      'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros '
      'laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet '
      'tellus. Sed ut perspiciatis unde omnis iste natus error sit voluptatem '
      'accusantium doloremque laudantium, totam rem aperiam.';

  // În Figma ultimele două amenități au ambele "Free Wi-fi" (text placeholder).
  static const _amenities = [
    _Amenity(Icons.shower_outlined, 'Showers'),
    _Amenity(Icons.view_agenda_outlined, 'Lockers'),
    _Amenity(Icons.wifi_rounded, 'Free Wi-fi'),
    _Amenity(Icons.wifi_rounded, 'Free Wi-fi'),
  ];

  bool _expanded = false;
  late final TapGestureRecognizer _readMoreTap = TapGestureRecognizer()
    ..onTap = () => setState(() => _expanded = !_expanded);

  @override
  void dispose() {
    _readMoreTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    const bottomBarHeight = 108.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // iconițe albe în status bar, fiindcă poza de sus e închisă
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: bottomBarHeight + padding.bottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Hero(topInset: padding.top),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TitleBlock(),
                          const SizedBox(height: 18),
                          Text.rich(
                            TextSpan(
                              style: AppText.bodySmallRegular(),
                              children: [
                                TextSpan(
                                  text: _expanded ? _fullText : _shortText,
                                ),
                                TextSpan(
                                  text: _expanded ? ' Show less' : ' Read more',
                                  style: AppText.bodySmallRegular(
                                    color: AppColors.primary,
                                  ),
                                  recognizer: _readMoreTap,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('Amenities', style: AppText.bodyLargeSemibold()),
                          const SizedBox(height: 16),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 52,
                            ),
                            itemCount: _amenities.length,
                            itemBuilder: (context, i) =>
                                _AmenityTile(_amenities[i]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomBar(bottomInset: padding.bottom),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Poza mare de sus + bara cu butonul înapoi și meniul
// ---------------------------------------------------------------------------

class _Hero extends StatelessWidget {
  const _Hero({required this.topInset});

  final double topInset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppImage('assets/images/gym_hero.jpg'),
          Positioned(
            top: topInset + 16,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0x80FFFFFF), // alb 50%
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: AppColors.grey25,
                    ),
                  ),
                ),
                const Icon(Icons.more_vert, size: 24, color: AppColors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Rating, titlu, locație (cu linie jos)
// ---------------------------------------------------------------------------

class _TitleBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
              const SizedBox(width: 8),
              Text.rich(
                TextSpan(
                  text: '4.5',
                  style: AppText.bodySmallSemibold(),
                  children: [
                    TextSpan(
                      text: ' (1,232 reviews)',
                      style: AppText.bodySmallRegular(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Mid City Gym Training', style: AppText.h4()),
          const SizedBox(height: 8),
          Text('California, New York', style: AppText.bodySmallRegular()),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Amenități
// ---------------------------------------------------------------------------

class _Amenity {
  const _Amenity(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _AmenityTile extends StatelessWidget {
  const _AmenityTile(this.amenity);

  final _Amenity amenity;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey25,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(amenity.icon, size: 20, color: AppColors.grey400),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              amenity.label,
              overflow: TextOverflow.ellipsis,
              style: AppText.bodySmallRegular(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bara fixă de jos: Total + butonul Reserve
// ---------------------------------------------------------------------------

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.bottomInset});

  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(25, 16, 25, math.max(bottomInset, 8) + 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // negru 10%
            blurRadius: 100,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: AppText.bodySmallMedium()),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: '\$69.00',
                    style: AppText.h6(),
                    children: [
                      TextSpan(
                        text: ' /week',
                        style: AppText.bodySmallRegular(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reserved!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Reserve',
                  style: AppText.bodyMediumSemibold(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
