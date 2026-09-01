import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import '../../core/theme/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showOnline = true;
  bool showLastSeen = true;
  bool matchNotifications = true;
  bool messageNotifications = true;
  bool questionNotifications = true;

  Color get _muted => Theme.of(context).brightness == Brightness.dark ? const Color(0xFF9F96AA) : const Color(0xFF746E7D);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
          children: [
            Row(children: [
              IconButton.filledTonal(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded)),
              const SizedBox(width: 12),
              Expanded(child: Text('Ayarlar', style: context.texts.headlineSmall?.copyWith(color: colors.onSurface, fontWeight: FontWeight.w900))),
            ]),
            const SizedBox(height: 24),
            const _SectionTitle('Hesap'),
            _SettingsCard(children: [
              _SettingsRow(icon: Icons.phone_iphone_rounded, title: 'Telefon numarası', subtitle: '+90 5•• ••• •• ••', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.verified_user_outlined, title: 'Hesap doğrulama', subtitle: 'Doğrulandı', trailingText: 'Aktif', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.lock_outline_rounded, title: 'Giriş yöntemleri', subtitle: 'Güvenli giriş seçeneklerini yönet', onTap: () {}),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Gizlilik ve güvenlik'),
            _SettingsCard(children: [
              _SwitchRow(icon: Icons.circle_outlined, title: 'Çevrimiçi durumunu göster', value: showOnline, onChanged: (v) => setState(() => showOnline = v)),
              _divider(context),
              _SwitchRow(icon: Icons.schedule_rounded, title: 'Son görülmeyi göster', value: showLastSeen, onChanged: (v) => setState(() => showLastSeen = v)),
              _divider(context),
              _SettingsRow(icon: Icons.visibility_outlined, title: 'Profil görünürlüğü', subtitle: 'Kimlerin seni görebileceğini seç', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.block_rounded, title: 'Engellenen kullanıcılar', onTap: () {}),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Keşfet ve eşleşme'),
            _SettingsCard(children: [
              _SettingsRow(icon: Icons.location_on_outlined, title: 'Konum', subtitle: 'İstanbul', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.social_distance_rounded, title: 'Mesafe aralığı', subtitle: '0 - 50 km', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.cake_outlined, title: 'Yaş aralığı', subtitle: '24 - 36', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.people_outline_rounded, title: 'Kimleri görmek istiyorsun?', subtitle: 'Tercihini düzenle', onTap: () {}),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Bildirimler'),
            _SettingsCard(children: [
              _SwitchRow(icon: Icons.favorite_border_rounded, title: 'Yeni eşleşmeler', value: matchNotifications, onChanged: (v) => setState(() => matchNotifications = v)),
              _divider(context),
              _SwitchRow(icon: Icons.chat_bubble_outline_rounded, title: 'Mesajlar', value: messageNotifications, onChanged: (v) => setState(() => messageNotifications = v)),
              _divider(context),
              _SwitchRow(icon: Icons.quiz_outlined, title: 'Günlük sorular', value: questionNotifications, onChanged: (v) => setState(() => questionNotifications = v)),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Görünüm'),
            _SettingsCard(children: [
              _SwitchRow(icon: darkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, title: 'Koyu tema', value: darkMode, onChanged: themeController.setDark),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Verilerim'),
            _SettingsCard(children: [
              _SettingsRow(icon: Icons.download_rounded, title: 'Verilerimi indir', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.policy_outlined, title: 'Gizlilik politikası', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.admin_panel_settings_outlined, title: 'Uygulama izinları', onTap: () {}),
            ]),
            const SizedBox(height: 22),
            const _SectionTitle('Hesap işlemleri'),
            _SettingsCard(children: [
              _SettingsRow(icon: Icons.pause_circle_outline_rounded, title: 'Hesabı dondur', subtitle: 'Profilini geçici olarak gizle', onTap: () {}),
              _divider(context),
              _SettingsRow(icon: Icons.delete_outline_rounded, title: 'Hesabı sil', subtitle: 'Bu işlem geri alınamaz', danger: true, onTap: () {}),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _divider(BuildContext context) => Divider(height: 1, color: context.colors.outlineVariant);

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: context.texts.titleMedium?.copyWith(color: context.colors.onSurface, fontWeight: FontWeight.w900)),
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.surfaceContainer,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: context.colors.outlineVariant),
    ),
    child: Column(children: children),
  );
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.title, required this.onTap, this.subtitle, this.trailingText, this.danger = false});
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final bool danger;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).brightness == Brightness.dark ? const Color(0xFF9F96AA) : const Color(0xFF746E7D);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(children: [
          Icon(icon, color: danger ? const Color(0xFFFF5267) : context.colors.primary),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: danger ? const Color(0xFFFF5267) : context.colors.onSurface, fontWeight: FontWeight.w800)),
            if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: TextStyle(color: muted, fontSize: 12.5))],
          ])),
          if (trailingText != null)
            Text(trailingText!, style: TextStyle(color: context.tokens.lime, fontWeight: FontWeight.w800, fontSize: 12))
          else
            Icon(Icons.chevron_right_rounded, color: muted),
        ]),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({required this.icon, required this.title, required this.value, required this.onChanged});
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      Icon(icon, color: context.colors.primary),
      const SizedBox(width: 13),
      Expanded(child: Text(title, style: TextStyle(color: context.colors.onSurface, fontWeight: FontWeight.w800))),
      Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF17131F),
        activeTrackColor: context.tokens.lime,
        inactiveThumbColor: const Color(0xFF8F879A),
        inactiveTrackColor: context.colors.surfaceContainerHighest,
      ),
    ]),
  );
}
