part of '../main.dart';

// Responsibility: Custom shapes and borders demonstration screens.

class _ShapesLabScreen extends StatelessWidget {
  const _ShapesLabScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'flutter_m3shapes_extended', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Shapes Lab',
            subtitle: 'Geometrias M3E para composiciones mas audaces.',
            icon: Icons.category,
          ),
          const SizedBox(height: 16),
          Text('Shape Lab', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Contenedores clippeados con geometrías Material 3 expresivas.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              m3shapes.M3EContainer.gem(
                width: 110,
                height: 110,
                color: cs.primaryContainer,
                child: Icon(Icons.diamond, color: cs.onPrimaryContainer),
              ),
              m3shapes.M3EContainer.flower(
                width: 110,
                height: 110,
                color: cs.secondaryContainer,
                child: Icon(Icons.local_florist, color: cs.onSecondaryContainer),
              ),
              m3shapes.M3EContainer.softBurst(
                width: 110,
                height: 110,
                color: cs.tertiaryContainer,
                child: Icon(Icons.brightness_high, color: cs.onTertiaryContainer),
              ),
              m3shapes.M3EContainer.puffyDiamond(
                width: 110,
                height: 110,
                color: cs.errorContainer,
                child: Icon(Icons.auto_awesome, color: cs.onErrorContainer),
              ),
              m3shapes.M3EContainer.boom(
                width: 110,
                height: 110,
                color: cs.surfaceContainerHighest,
                child: Icon(Icons.flash_on, color: cs.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

