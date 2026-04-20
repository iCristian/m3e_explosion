part of '../main.dart';

// Responsibility: Custom shapes and borders demonstration screens.

class _ShapesLabScreen extends StatelessWidget {
  const _ShapesLabScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'flutter_m3shapes_extended', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: l10n.shapesTitle,
            subtitle: l10n.shapesSubtitle,
            icon: Icons.category,
          ),
          const SizedBox(height: 20),

          // ── 1. Basic Shapes ───────────────────────────────────────────
          _ShapesSectionHeader(title: l10n.shapesBasic, desc: l10n.shapesBasicDesc),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              m3shapes.M3EContainer.gem(
                width: 110, height: 110, color: cs.primaryContainer,
                child: Icon(Icons.diamond, color: cs.onPrimaryContainer)),
              m3shapes.M3EContainer.flower(
                width: 110, height: 110, color: cs.secondaryContainer,
                child: Icon(Icons.local_florist, color: cs.onSecondaryContainer)),
              m3shapes.M3EContainer.softBurst(
                width: 110, height: 110, color: cs.tertiaryContainer,
                child: Icon(Icons.brightness_high, color: cs.onTertiaryContainer)),
              m3shapes.M3EContainer.puffyDiamond(
                width: 110, height: 110, color: cs.errorContainer,
                child: Icon(Icons.auto_awesome, color: cs.onErrorContainer)),
              m3shapes.M3EContainer.boom(
                width: 110, height: 110, color: cs.surfaceContainerHighest,
                child: Icon(Icons.flash_on, color: cs.onSurface)),
            ],
          ),
          const SizedBox(height: 28),

          // ── 2. Animated Shapes ────────────────────────────────────────
          _ShapesSectionHeader(title: l10n.shapesAnimated, desc: l10n.shapesAnimatedDesc),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              m3shapes.M3EContainer.gem(
                width: 90, height: 90, color: cs.primaryContainer,
                child: Icon(Icons.diamond, color: cs.onPrimaryContainer))
                .animate(onPlay: (c) => c.repeat())
                .rotate(duration: const Duration(milliseconds: 4000)),
              m3shapes.M3EContainer.flower(
                width: 90, height: 90, color: cs.secondaryContainer,
                child: Icon(Icons.local_florist, color: cs.onSecondaryContainer))
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(0.85, 0.85),
                  end: const Offset(1.1, 1.1),
                  duration: const Duration(milliseconds: 1400)),
              m3shapes.M3EContainer.softBurst(
                width: 90, height: 90, color: cs.tertiaryContainer,
                child: Icon(Icons.star, color: cs.onTertiaryContainer))
                .animate(onPlay: (c) => c.repeat())
                .shimmer(
                  duration: const Duration(milliseconds: 2000),
                  color: cs.onTertiaryContainer.withValues(alpha: 0.3)),
              m3shapes.M3EContainer.puffyDiamond(
                width: 90, height: 90, color: cs.errorContainer,
                child: Icon(Icons.auto_awesome, color: cs.onErrorContainer))
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .rotate(begin: -0.08, end: 0.08, duration: const Duration(milliseconds: 1800)),
              m3shapes.M3EContainer.boom(
                width: 90, height: 90, color: cs.primary,
                child: Icon(Icons.flash_on, color: cs.onPrimary))
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 0.9, end: 1.15, duration: const Duration(milliseconds: 900)),
            ],
          ),
          const SizedBox(height: 28),

          // ── 3. Advanced Compositions ──────────────────────────────────
          _ShapesSectionHeader(title: l10n.shapesAdvanced, desc: l10n.shapesAdvancedDesc),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  m3shapes.M3EContainer.softBurst(width: 100, height: 100,
                    color: cs.primary.withValues(alpha: 0.25)),
                  m3shapes.M3EContainer.gem(width: 68, height: 68, color: cs.primary,
                    child: Icon(Icons.star, color: cs.onPrimary, size: 28)),
                ],
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1.05, 1.05),
                  duration: const Duration(milliseconds: 1600)),
              Stack(
                alignment: Alignment.center,
                children: [
                  m3shapes.M3EContainer.flower(width: 100, height: 100,
                    color: cs.secondary.withValues(alpha: 0.25)),
                  m3shapes.M3EContainer.puffyDiamond(width: 68, height: 68, color: cs.secondary,
                    child: Icon(Icons.favorite, color: cs.onSecondary, size: 28)),
                ],
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .rotate(begin: -0.04, end: 0.04, duration: const Duration(milliseconds: 2200)),
              Stack(
                alignment: Alignment.center,
                children: [
                  m3shapes.M3EContainer.boom(width: 110, height: 110,
                    color: cs.tertiary.withValues(alpha: 0.18)),
                  m3shapes.M3EContainer.flower(width: 72, height: 72, color: cs.tertiary,
                    child: Icon(Icons.bolt, color: cs.onTertiary, size: 30)),
                ],
              ).animate(onPlay: (c) => c.repeat())
               .shimmer(
                  duration: const Duration(milliseconds: 3000),
                  color: cs.tertiary.withValues(alpha: 0.2)),
            ],
          ),
          const SizedBox(height: 28),

          // ── 4. Interactive Playground ─────────────────────────────────
          _ShapesSectionHeader(title: l10n.shapesInteractive, desc: l10n.shapesInteractiveDesc),
          const SizedBox(height: 12),
          const _InteractiveShapesPlayground(),
          const SizedBox(height: 28),

          // ── 5. Usage Examples ─────────────────────────────────────────
          _ShapesSectionHeader(title: l10n.shapesUsage, desc: l10n.shapesUsageDesc),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  m3shapes.M3EContainer.flower(width: 56, height: 56,
                    color: cs.primaryContainer,
                    child: Icon(Icons.person, color: cs.onPrimaryContainer, size: 28)),
                  const SizedBox(height: 4),
                  Text('Avatar', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  m3shapes.M3EContainer.softBurst(width: 56, height: 56,
                    color: cs.primary,
                    child: Icon(Icons.add, color: cs.onPrimary, size: 28)),
                  const SizedBox(height: 4),
                  Text('FAB', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      m3shapes.M3EContainer.gem(width: 56, height: 56,
                        color: cs.secondaryContainer,
                        child: Icon(Icons.notifications, color: cs.onSecondaryContainer)),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: m3shapes.M3EContainer.boom(
                          width: 24, height: 24, color: cs.error,
                          child: Text('3',
                            style: TextStyle(
                              color: cs.onError,
                              fontSize: 10,
                              fontWeight: FontWeight.w800))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Badge', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  m3shapes.M3EContainer.puffyDiamond(width: 56, height: 56,
                    color: cs.tertiaryContainer,
                    child: Icon(Icons.settings, color: cs.onTertiaryContainer)),
                  const SizedBox(height: 4),
                  Text('Icon btn', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ShapesSectionHeader extends StatelessWidget {
  const _ShapesSectionHeader({required this.title, required this.desc});
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text(desc,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _InteractiveShapesPlayground extends StatefulWidget {
  const _InteractiveShapesPlayground();

  @override
  State<_InteractiveShapesPlayground> createState() => _InteractiveShapesPlaygroundState();
}

class _InteractiveShapesPlaygroundState extends State<_InteractiveShapesPlayground> {
  final List<bool> _pressed = List.filled(4, false);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final colors = [cs.primary, cs.secondary, cs.tertiary, cs.error];
    final onColors = [cs.onPrimary, cs.onSecondary, cs.onTertiary, cs.onError];
    final icons = [Icons.diamond, Icons.local_florist, Icons.star, Icons.flash_on];

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: List.generate(4, (i) {
        final active = _pressed[i];
        final color = colors[i];
        final onColor = onColors[i];
        final icon = icons[i];

        Widget buildShape(Color c, Widget child) {
          switch (i) {
            case 0:
              return m3shapes.M3EContainer.gem(width: 90, height: 90, color: c, child: child);
            case 1:
              return m3shapes.M3EContainer.flower(width: 90, height: 90, color: c, child: child);
            case 2:
              return m3shapes.M3EContainer.softBurst(width: 90, height: 90, color: c, child: child);
            default:
              return m3shapes.M3EContainer.boom(width: 90, height: 90, color: c, child: child);
          }
        }

        return GestureDetector(
          onTapDown: (_) => setState(() => _pressed[i] = true),
          onTapUp: (_) => setState(() => _pressed[i] = false),
          onTapCancel: () => setState(() => _pressed[i] = false),
          child: AnimatedScale(
            scale: active ? 1.18 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutBack,
            child: buildShape(
              active ? color : color.withValues(alpha: 0.55),
              Icon(icon, color: onColor, size: active ? 34 : 28),
            ),
          ),
        );
      }),
    );
  }
}

