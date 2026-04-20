part of '../main.dart';

// Responsibility: Progress indicators and motion/animation screens.

class _ProgressAndMotionScreen extends StatefulWidget {
  const _ProgressAndMotionScreen();

  @override
  State<_ProgressAndMotionScreen> createState() => _ProgressAndMotionScreenState();
}

class _ProgressAndMotionScreenState extends State<_ProgressAndMotionScreen> {
  double _value = 0.62;
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Progress, Slider & Motion', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Motion and Progress Lab',
            subtitle: 'Indicadores morfologicos, sliders y micro-animaciones continuas.',
            icon: Icons.animation,
          ),
          const SizedBox(height: 16),
          Text('Progress Indicator M3E', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          LinearProgressIndicatorM3E(value: _value),
          const SizedBox(height: 14),
          Row(
            children: [
              CircularProgressIndicatorM3E(value: _value),
              const SizedBox(width: 20),
              ProgressWithLabelM3E(value: _value),
              const SizedBox(width: 20),
              const LoadingIndicatorM3E(),
              const SizedBox(width: 20),
              const SizedBox(width: 48, height: 48, child: eli.ExpressiveLoadingIndicator()),
            ],
          ),
          const SizedBox(height: 28),
          Text('Slider M3E', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SliderM3E(
            value: _value,
            onChanged: (v) => setState(() => _value = v),
            size: SliderM3ESize.large,
            showValueIndicator: true,
            startIcon: const Icon(Icons.volume_mute),
            endIcon: const Icon(Icons.volume_up),
          ),
          const SizedBox(height: 12),
          RangeSliderM3E(
            values: RangeValues(_value * 0.5, _value),
            onChanged: (_) {},
          ),
          const SizedBox(height: 28),
          Text('Motion demo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _toggled = !_toggled),
            child: AnimatedContainer(
              duration: 700.ms,
              curve: Curves.easeInOutCubicEmphasized,
              width: _toggled ? 260 : 140,
              height: _toggled ? 120 : 180,
              decoration: BoxDecoration(
                color: _toggled ? cs.primary : cs.tertiary,
                borderRadius: BorderRadius.circular(_toggled ? 60 : 24),
              ),
              child: Icon(_toggled ? Icons.play_arrow : Icons.pause, color: cs.onPrimary, size: 56),
            ),
          ).animate().fadeIn().shimmer(duration: 1800.ms, color: cs.primary.withValues(alpha: 0.1)),
        ],
      ),
    );
  }
}

