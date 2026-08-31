import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class PartnerPreferencesScreen extends StatefulWidget {
  const PartnerPreferencesScreen({super.key});

  @override
  State<PartnerPreferencesScreen> createState() => _PartnerPreferencesScreenState();
}

class _PartnerPreferencesScreenState extends State<PartnerPreferencesScreen> {
  final Map<int, Set<String>> selections = {};

  static const questions = <_PreferenceQuestion>[
    _PreferenceQuestion(
      title: 'Daha önce evlendiniz mi?',
      options: ['Daha önce evlenmiş', 'Daha önce evlenmemiş'],
      icon: Icons.favorite_rounded,
      multiSelect: false,
    ),
    _PreferenceQuestion(
      title: 'Çocuğunuz var mı?',
      options: ['Çocuğu var', 'Çocuğu yok'],
      icon: Icons.child_care_rounded,
      multiSelect: false,
    ),
    _PreferenceQuestion(
      title: 'Gelecekte çocuk sahibi olmak ister misiniz?',
      options: [
        'Kesinlikle istemesin',
        'İstemesin',
        'Kararsız olsun',
        'İstesin',
        'Kesinlikle istesin',
      ],
      icon: Icons.family_restroom_rounded,
      multiSelect: true,
    ),
    _PreferenceQuestion(
      title: 'Ne sıklıkla sigara kullanırsınız?',
      options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık'],
      icon: Icons.smoking_rooms_rounded,
      multiSelect: true,
    ),
    _PreferenceQuestion(
      title: 'Ne sıklıkla alkol kullanırsınız?',
      options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık'],
      icon: Icons.local_bar_rounded,
      multiSelect: true,
    ),
    _PreferenceQuestion(
      title: 'Tamamladığınız en yüksek eğitim düzeyi nedir?',
      options: ['İlköğretim', 'Lise', 'Ön lisans / Lisans', 'Yüksek lisans', 'Doktora'],
      icon: Icons.school_rounded,
      multiSelect: true,
    ),
  ];

  int get selectedPreferenceCount =>
      selections.values.where((value) => value.isNotEmpty).length;

  int get remainingRights => (2 - selectedPreferenceCount).clamp(0, 2);

  Future<void> _openQuestion(int index) async {
    final result = await Navigator.of(context).push<Set<String>>(
      MaterialPageRoute(
        builder: (_) => PartnerPreferenceDetailScreen(
          question: questions[index],
          initialSelection: selections[index] ?? <String>{},
        ),
      ),
    );
    if (result == null) return;
    setState(() => selections[index] = result);
  }

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF090712);

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: [
            _PartnerHero(
              onBack: () => Navigator.of(context).pop(),
              selectedCount: selectedPreferenceCount,
              remainingRights: remainingRights,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spaceLg,
                  14,
                  context.tokens.spaceLg,
                  40,
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < questions.length; i++) ...[
                      _PreferenceTile(
                        question: questions[i],
                        selectedValues: selections[i] ?? <String>{},
                        onTap: () => _openQuestion(i),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartnerPreferenceDetailScreen extends StatefulWidget {
  const PartnerPreferenceDetailScreen({
    super.key,
    required this.question,
    required this.initialSelection,
  });

  final _PreferenceQuestion question;
  final Set<String> initialSelection;

  @override
  State<PartnerPreferenceDetailScreen> createState() =>
      _PartnerPreferenceDetailScreenState();
}

class _PartnerPreferenceDetailScreenState
    extends State<PartnerPreferenceDetailScreen> {
  late Set<String> selected;
  bool doesntMatter = false;

  @override
  void initState() {
    super.initState();
    selected = {...widget.initialSelection};
  }

  void _toggle(String option) {
    setState(() {
      doesntMatter = false;
      if (widget.question.multiSelect) {
        if (!selected.add(option)) selected.remove(option);
      } else {
        selected = {option};
      }
    });
  }

  void _toggleDoesntMatter() {
    setState(() {
      doesntMatter = !doesntMatter;
      if (doesntMatter) selected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF090712);
    final canSave = selected.isNotEmpty || doesntMatter;

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: [
            _PreferenceDetailHero(
              icon: widget.question.icon,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spaceLg,
                  14,
                  context.tokens.spaceLg,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.question.title,
                      style: context.texts.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Karşınızdaki kişide aradığınız cevabı seçin.',
                      style: context.texts.bodyLarge?.copyWith(
                        color: const Color(0xFFC9C3D5),
                      ),
                    ),
                    if (widget.question.multiSelect) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Sizin için uygun olan birden fazla cevabı seçebilirsiniz.',
                        style: context.texts.bodyMedium?.copyWith(
                          color: const Color(0xFF8F879A),
                        ),
                      ),
                    ],
                    const SizedBox(height: 22),
                    for (final option in widget.question.options) ...[
                      _PreferenceOptionCard(
                        label: option,
                        selected: selected.contains(option),
                        square: widget.question.multiSelect,
                        onTap: () => _toggle(option),
                      ),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 4),
                    const Divider(color: Color(0xFF31283D)),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _toggleDoesntMatter,
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: doesntMatter
                              ? context.tokens.lime.withOpacity(.10)
                              : const Color(0xFF14101D),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: doesntMatter
                                ? context.tokens.lime
                                : const Color(0xFF31283D),
                            width: doesntMatter ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.remove_circle_outline_rounded,
                              color: doesntMatter
                                  ? context.tokens.lime
                                  : const Color(0xFF9E95AA),
                              size: 30,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fark etmez',
                                    style: context.texts.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Bu seçim tercihi etkinleştirir ve bir tercih hakkı kullanır.',
                                    style: context.texts.bodyMedium?.copyWith(
                                      color: const Color(0xFFC9C3D5),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          context.tokens.spaceLg,
          10,
          context.tokens.spaceLg,
          16,
        ),
        child: SizedBox(
          height: 58,
          child: FilledButton(
            onPressed: canSave
                ? () => Navigator.of(context).pop<Set<String>>(
                      doesntMatter ? {'Fark etmez'} : selected,
                    )
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: context.tokens.lime,
              foregroundColor: black,
              disabledBackgroundColor: const Color(0xFF221B30),
              disabledForegroundColor: const Color(0xFF6E6878),
            ),
            child: const Text(
              'Tercihi kaydet',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _PreferenceQuestion {
  const _PreferenceQuestion({
    required this.title,
    required this.options,
    required this.icon,
    required this.multiSelect,
  });

  final String title;
  final List<String> options;
  final IconData icon;
  final bool multiSelect;
}

class _PartnerHero extends StatelessWidget {
  const _PartnerHero({
    required this.onBack,
    required this.selectedCount,
    required this.remainingRights,
  });

  final VoidCallback onBack;
  final int selectedCount;
  final int remainingRights;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: ClipPath(
        clipper: _OvalBottomClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9A4DFF),
                Color(0xFF6D21D7),
                Color(0xFF45108D),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 14,
                child: IconButton.filledTonal(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              Positioned(
                left: 28,
                right: 28,
                top: 68,
                child: Text(
                  'Partner Tercihleri',
                  style: context.texts.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Positioned(
                left: 28,
                right: 28,
                top: 120,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(.16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            color: context.tokens.lime,
                            size: 30,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Sizin için en önemli iki tercihi seçin. Her seçim bir tercih hakkı kullanır.',
                              style: context.texts.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '2 başlangıç tercihinden $selectedCount tanesi seçildi',
                        style: context.texts.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: selectedCount / 2,
                          minHeight: 7,
                          backgroundColor: Colors.white.withOpacity(.18),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.tokens.lime,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number_outlined,
                            color: Color(0xFFE2DAEC),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$remainingRights tercih hakkınız var.',
                            style: context.texts.bodyLarge?.copyWith(
                              color: const Color(0xFFE2DAEC),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreferenceDetailHero extends StatelessWidget {
  const _PreferenceDetailHero({
    required this.icon,
    required this.onBack,
  });

  final IconData icon;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: ClipPath(
        clipper: _OvalBottomClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9A4DFF),
                Color(0xFF6D21D7),
                Color(0xFF45108D),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 14,
                child: IconButton.filledTonal(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              Positioned(
                left: 28,
                top: 86,
                child: Text(
                  'Partner Tercihleri',
                  style: context.texts.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Positioned(
                right: 34,
                top: 40,
                child: _HeroIcon(icon: icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 104,
      decoration: BoxDecoration(
        color: const Color(0xFF2A1255).withOpacity(.84),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: Icon(icon, size: 54, color: context.tokens.lime),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.question,
    required this.selectedValues,
    required this.onTap,
  });

  final _PreferenceQuestion question;
  final Set<String> selectedValues;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedValues.isNotEmpty;
    final subtitle = hasSelection ? selectedValues.join(', ') : 'Henüz seçilmedi';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF14101D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF31283D)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF21172F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(question.icon, color: context.tokens.lime),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.title,
                    style: context.texts.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.texts.bodyMedium?.copyWith(
                      color: hasSelection
                          ? context.tokens.lime
                          : const Color(0xFF9E95AA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFC9C3D5),
                ),
                Text(
                  'Seç',
                  style: context.texts.labelMedium?.copyWith(
                    color: const Color(0xFFC9C3D5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceOptionCard extends StatelessWidget {
  const _PreferenceOptionCard({
    required this.label,
    required this.selected,
    required this.square,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool square;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: selected
              ? context.tokens.lime.withOpacity(.10)
              : const Color(0xFF14101D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? context.tokens.lime : const Color(0xFF31283D),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              square
                  ? (selected
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded)
                  : (selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded),
              color: selected ? context.tokens.lime : const Color(0xFF9E95AA),
              size: 30,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: context.texts.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 46);
    path.quadraticBezierTo(
      size.width * .5,
      size.height + 22,
      size.width,
      size.height - 46,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
