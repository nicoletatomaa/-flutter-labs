import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../widgets/app_image.dart';
import 'fitness_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];

  static const _plans = [
    _Plan(
      title: 'Massive Upper Body',
      weeks: '5 week',
      perWeek: '4x/week',
      image: 'assets/images/featured.jpg',
    ),
    _Plan(
      title: 'Massive Upper Body',
      weeks: '5 week',
      perWeek: '4x/week',
      image: 'assets/images/featured.jpg',
    ),
  ];

  static const _programs = [
    _Program(
      name: 'Yoga',
      kcal: '210 kcl',
      minutes: '120 min',
      image: 'assets/images/yoga.jpg',
    ),
    _Program(
      name: 'Arm Strengthening',
      kcal: '210 kcl',
      minutes: '120 min',
      image: 'assets/images/arm_strength.jpg',
      isPro: true,
    ),
  ];

  int _selectedCategory = 0;

  void _openFitness() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FitnessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _Header(),
                ),
                const SizedBox(height: 28),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _ChallengeCard(current: 15, total: 20),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _SectionTitle('Featured Plan'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 144,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _plans.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, i) =>
                        _FeaturedCard(plan: _plans[i], onStart: _openFitness),
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _SectionTitle('Workout Programs'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, i) => _CategoryChip(
                      label: _categories[i],
                      selected: i == _selectedCategory,
                      onTap: () => setState(() => _selectedCategory = i),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 184,
                    ),
                    itemCount: _programs.length,
                    itemBuilder: (context, i) => _ProgramCard(
                      program: _programs[i],
                      onTap: _openFitness,
                    ),
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

// ---------------------------------------------------------------------------
// Modele de date
// ---------------------------------------------------------------------------

class _Plan {
  const _Plan({
    required this.title,
    required this.weeks,
    required this.perWeek,
    required this.image,
  });

  final String title;
  final String weeks;
  final String perWeek;
  final String image;
}

class _Program {
  const _Program({
    required this.name,
    required this.kcal,
    required this.minutes,
    required this.image,
    this.isPro = false,
  });

  final String name;
  final String kcal;
  final String minutes;
  final String image;
  final bool isPro;
}

// ---------------------------------------------------------------------------
// Header: dată, salut, clopoțel
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Friday, 20 May', style: AppText.bodySmallRegular()),
            const SizedBox(height: 4),
            Text('Good Morning', style: AppText.h6()),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey100),
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 24,
                  color: AppColors.grey900,
                ),
              ),
              Positioned(
                left: 25,
                top: 15,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Cardul negru "Today's Challenge" cu inel de progres
// ---------------------------------------------------------------------------

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.grey900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today’s Challenge',
                style: AppText.bodySmallRegular(color: AppColors.grey300),
              ),
              const SizedBox(height: 4),
              Text('Running', style: AppText.h6(color: AppColors.white)),
            ],
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: current / total,
                    strokeWidth: 5,
                    backgroundColor: AppColors.grey700,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text('$current/$total', style: AppText.bodyXSmallMedium()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Titlu de secțiune + "See All"
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: AppText.bodyLargeSemibold()),
        Text('See All', style: AppText.bodySmallSemibold(color: AppColors.primary)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Card "Featured Plan" (296 x 144)
// ---------------------------------------------------------------------------

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.plan, required this.onStart});

  final _Plan plan;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 296,
        height: 144,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(plan.image),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.title, style: AppText.h6(color: AppColors.white)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.fitness_center,
                              size: 16, color: AppColors.white),
                          const SizedBox(width: 4),
                          Text(plan.weeks, style: AppText.bodyXSmallRegular()),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(plan.perWeek, style: AppText.bodyXSmallRegular()),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      minimumSize: const Size(88, 32),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text('Start Now', style: AppText.bodyXSmallSemibold()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chip-uri de categorie (All Type / Pilates / ...)
// ---------------------------------------------------------------------------

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: selected ? null : Border.all(color: AppColors.grey100),
        ),
        child: Text(
          label,
          style: AppText.bodySmallMedium(
            color: selected ? AppColors.white : AppColors.grey400,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card "Workout Program" (155.5 x 184) cu gradient și badge Pro
// ---------------------------------------------------------------------------

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program, required this.onTap});

  final _Program program;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(program.image),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xCC000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  if (program.isPro)
                    const Align(
                      alignment: Alignment.topRight,
                      child: _ProBadge(),
                    ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.name,
                          style: AppText.bodyMediumSemibold(
                              color: AppColors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _Stat(
                                icon: Icons.local_fire_department_outlined,
                                text: program.kcal),
                            _Stat(
                                icon: Icons.access_time,
                                text: program.minutes),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.grey200),
        const SizedBox(width: 3),
        Text(text, style: AppText.caption()),
      ],
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.workspace_premium_outlined,
              size: 14, color: AppColors.primary),
          const SizedBox(width: 3),
          Text('Pro', style: AppText.bodyXSmallMedium(color: AppColors.primary)),
        ],
      ),
    );
  }
}
