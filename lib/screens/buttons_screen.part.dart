part of '../main.dart';

// Responsibility: Buttons and interactive control screens.

class _ButtonsScreen extends StatelessWidget {
  const _ButtonsScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Buttons & Toolbar M3E', actions: [_appBarBrandIcon()]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBlast(
              title: l10n.buttonsPlaygroundTitle,
              subtitle: l10n.buttonsPlaygroundSubtitle,
              icon: Icons.smart_button,
            ),
            const SizedBox(height: 16),
            Text(l10n.buttonsVariantsTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ButtonM3E(
                  label: Text(l10n.buttonsFilledLabel),
                  style: ButtonM3EStyle.filled,
                  size: ButtonM3ESize.sm,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: Text(l10n.buttonsTonalLabel),
                  style: ButtonM3EStyle.tonal,
                  size: ButtonM3ESize.md,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: Text(l10n.buttonsOutlinedLabel),
                  style: ButtonM3EStyle.outlined,
                  size: ButtonM3ESize.lg,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: Text(l10n.buttonsTextLabel),
                  style: ButtonM3EStyle.text,
                  onPressed: () {},
                ),
                ButtonM3E(
                  label: Text(l10n.buttonsElevatedLabel),
                  style: ButtonM3EStyle.elevated,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonsIconTitle, style: Theme.of(context).textTheme.titleLarge),
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
            Text(l10n.buttonsSplitTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SplitButtonM3E<String>(
              label: l10n.buttonsSplitSaveLabel,
              onPressed: () {},
              items: [
                SplitButtonM3EItem<String>(value: 'save', child: Text(l10n.buttonsSplitSaveLabel)),
                SplitButtonM3EItem<String>(value: 'saveAs', child: Text(l10n.buttonsSplitSaveAsLabel)),
              ],
              onSelected: (value) {},
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonsGroupTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ButtonGroupM3E(
              selection: true,
              selectedIndex: 1,
              actions: [
                ButtonGroupM3EAction(label: Text(l10n.buttonsGroupDayLabel), onPressed: () {}),
                ButtonGroupM3EAction(label: Text(l10n.buttonsGroupWeekLabel), onPressed: () {}),
                ButtonGroupM3EAction(label: Text(l10n.buttonsGroupMonthLabel), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonsToolbarTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ToolbarM3E(
              titleText: l10n.buttonsEditorTitle,
              actions: [
                ToolbarActionM3E(icon: Icons.format_bold, onPressed: () {}, label: l10n.buttonsToolbarBoldLabel),
                ToolbarActionM3E(icon: Icons.format_italic, onPressed: () {}, label: l10n.buttonsToolbarItalicLabel),
                ToolbarActionM3E(icon: Icons.format_underlined, onPressed: () {}, label: l10n.buttonsToolbarUnderlineLabel),
                ToolbarActionM3E(icon: Icons.delete_outline, onPressed: () {}, label: l10n.buttonsToolbarDeleteLabel, isDestructive: true),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonsM3ePackageTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.filled,
                  child: Text(l10n.buttonsM3eFilledLabel),
                ),
                m3eb.M3EButton(
                  onPressed: () {},
                  style: m3eb.M3EButtonStyle.tonal,
                  child: Text(l10n.buttonsM3eTonalLabel),
                ),
                m3eb.M3EButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: Text(l10n.buttonsM3eIconLabel),
                  style: m3eb.M3EButtonStyle.outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            m3eb.M3ESplitButton<String>(
              label: l10n.buttonsSplitV2Label,
              onPressed: () {},
              onSelected: (_) {},
              items: [
                m3eb.M3ESplitButtonItem<String>(value: 'copy', child: Text(l10n.buttonsSplitCopyLabel)),
                m3eb.M3ESplitButtonItem<String>(value: 'move', child: Text(l10n.buttonsSplitMoveLabel)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

