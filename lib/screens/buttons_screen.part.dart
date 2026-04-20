part of '../main.dart';

// Responsibility: Buttons and interactive control screens.

class _ButtonsScreen extends StatelessWidget {
  const _ButtonsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Buttons & Toolbar M3E', actions: [_appBarBrandIcon()]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroBlast(
              title: 'Buttons Playground',
              subtitle: 'Variantes expresivas, split actions y motion en estado puro.',
              icon: Icons.smart_button,
            ),
            const SizedBox(height: 16),
            Text('ButtonM3E Variants', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ButtonM3E(
                  label: const Text('Filled SM'),
                  style: ButtonM3EStyle.filled,
                  size: ButtonM3ESize.sm,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Tonal MD'),
                  style: ButtonM3EStyle.tonal,
                  size: ButtonM3ESize.md,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Outlined LG'),
                  style: ButtonM3EStyle.outlined,
                  size: ButtonM3ESize.lg,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Text'),
                  style: ButtonM3EStyle.text,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: const Text('Elevated'),
                  style: ButtonM3EStyle.elevated,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('IconButtonM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                IconButtonM3E(icon: const Icon(Icons.favorite), onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.bookmark), variant: IconButtonM3EVariant.tonal, onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.share), variant: IconButtonM3EVariant.filled, onPressed: () {}),
                IconButtonM3E(icon: const Icon(Icons.delete), variant: IconButtonM3EVariant.outlined, onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Text('SplitButtonM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SplitButtonM3E<String>(
              label: 'Guardar',
              onPressed: () {},
              items: const [
                SplitButtonM3EItem<String>(value: 'save', child: Text('Guardar')),
                SplitButtonM3EItem<String>(value: 'saveAs', child: Text('Guardar como')),
              ],
              onSelected: (value) {},
            ),
            const SizedBox(height: 24),
            Text('ButtonGroupM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ButtonGroupM3E(
              selection: true,
              selectedIndex: 1,
              actions: [
                ButtonGroupM3EAction(label: const Text('Dia'), onPressed: () {}),
                ButtonGroupM3EAction(label: const Text('Semana'), onPressed: () {}),
                ButtonGroupM3EAction(label: const Text('Mes'), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Text('ToolbarM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ToolbarM3E(
              titleText: 'Editor Expresivo',
              actions: [
                ToolbarActionM3E(icon: Icons.format_bold, onPressed: () {}, label: 'Negrita'),
                ToolbarActionM3E(icon: Icons.format_italic, onPressed: () {}, label: 'Cursiva'),
                ToolbarActionM3E(icon: Icons.format_underlined, onPressed: () {}, label: 'Subrayado'),
                ToolbarActionM3E(icon: Icons.delete_outline, onPressed: () {}, label: 'Borrar', isDestructive: true),
              ],
            ),
            const SizedBox(height: 24),
            Text('m3e_buttons package', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.filled,
                  child: const Text('M3E Filled'),
                ),
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.tonal,
                  child: const Text('M3E Tonal'),
                ),
                m3eb.M3EButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Icon Button'),
                  style: m3eb.M3EButtonStyle.outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            m3eb.M3ESplitButton<String>(
              label: 'Split v2',
              onPressed: () {},
              onSelected: (_) {},
              items: const [
                m3eb.M3ESplitButtonItem<String>(value: 'copy', child: Text('Copiar')),
                m3eb.M3ESplitButtonItem<String>(value: 'move', child: Text('Mover')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

