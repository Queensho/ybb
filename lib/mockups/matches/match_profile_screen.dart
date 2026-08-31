import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class MatchProfileScreen extends StatelessWidget {
  const MatchProfileScreen({
    super.key,
    required this.name,
    required this.city,
    required this.age,
    required this.score,
    required this.interests,
    required this.status,
    required this.online,
    required this.imageUrl,
    required this.verified,
  });

  final String name;
  final String city;
  final int age;
  final int score;
  final List<String> interests;
  final String status;
  final bool online;
  final bool verified;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF090712);
    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 390,
            pinned: true,
            backgroundColor: const Color(0xFF5B18B8),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _CircleButton(icon: Icons.arrow_back_rounded, onTap: () => Navigator.pop(context)),
            ),
            actions: const [
              Padding(padding: EdgeInsets.only(right: 12), child: _CircleButton(icon: Icons.more_horiz_rounded)),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF4B168F), child: Icon(Icons.person_rounded, size: 120, color: Colors.white54))),
                  const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Color(0x33000000), Color(0xFF090712)], stops: [0.42, .72, 1]))),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Flexible(child: Text('$name, $age', style: const TextStyle(color: Colors.white, fontSize: 34, height: 1, fontWeight: FontWeight.w900))),
                        if (verified) const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.verified_rounded, color: Color(0xFF9A4DFF), size: 25)),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.circle, size: 9, color: online ? context.tokens.lime : Colors.white54),
                        const SizedBox(width: 7),
                        Text(status, style: TextStyle(color: online ? context.tokens.lime : Colors.white70, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 14),
                        const Icon(Icons.location_on_outlined, color: Colors.white70, size: 18),
                        const SizedBox(width: 3),
                        Text(city, style: const TextStyle(color: Colors.white70)),
                      ]),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 120),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _CompatibilityCard(score: score),
                const SizedBox(height: 18),
                const _SectionTitle('Ortak noktalar'),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: interests.map((e) => _Chip(label: e)).toList()),
                const SizedBox(height: 22),
                const _SectionTitle('Uyum özeti'),
                const SizedBox(height: 10),
                const _InfoCard(children: [
                  _InfoRow(icon: Icons.question_answer_outlined, title: 'Ortak cevaplar', value: '4 ortak cevap'),
                  _InfoRow(icon: Icons.tune_rounded, title: 'Partner tercihleri', value: '2 tercih uyumlu'),
                  _InfoRow(icon: Icons.translate_rounded, title: 'Konuştuğu dil', value: 'Türkçe'),
                ]),
                const SizedBox(height: 22),
                const _SectionTitle('Hakkında'),
                const SizedBox(height: 10),
                _InfoCard(children: [
                  const Text('Yeni insanlarla tanışmayı, güzel sohbetleri ve küçük kaçamakları seviyorum. Ortak noktalarımız varsa tanışalım.', style: TextStyle(color: Color(0xFFD5CDDF), fontSize: 15, height: 1.55)),
                ]),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          color: bg,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
          child: Row(children: [
            Container(width: 58, height: 58, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4C405E))), child: Icon(Icons.favorite_border_rounded, color: context.tokens.lime)),
            const SizedBox(width: 12),
            Expanded(child: SizedBox(height: 58, child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_bubble_rounded), label: const Text('Mesaj gönder'), style: FilledButton.styleFrom(backgroundColor: context.tokens.lime, foregroundColor: Colors.black, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))),
          ]),
        ),
      ),
    );
  }
}

class _CompatibilityCard extends StatelessWidget {
  const _CompatibilityCard({required this.score}); final int score;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF14111D), borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0xFF30263E))),
    child: Column(children: [
      Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFF25183B), borderRadius: BorderRadius.circular(16)), child: Icon(Icons.auto_awesome_rounded, color: context.tokens.lime)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Eşleşme uyumu', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)), Text('%$score', style: TextStyle(color: context.tokens.lime, fontSize: 30, fontWeight: FontWeight.w900))])), const Icon(Icons.chevron_right_rounded, color: Colors.white38)]),
      const SizedBox(height: 14), ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: score / 100, minHeight: 8, backgroundColor: const Color(0xFF30283A), valueColor: AlwaysStoppedAnimation(context.tokens.lime))),
      const SizedBox(height: 10), const Align(alignment: Alignment.centerLeft, child: Text('Cevaplarınız ve partner tercihleriniz karşılaştırılarak hesaplanır.', style: TextStyle(color: Color(0xFF948B9E), fontSize: 12, height: 1.35))),
    ]),
  );
}
class _SectionTitle extends StatelessWidget { const _SectionTitle(this.text); final String text; @override Widget build(BuildContext context) => Text(text, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)); }
class _Chip extends StatelessWidget { const _Chip({required this.label}); final String label; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9), decoration: BoxDecoration(color: const Color(0xFF21162F), borderRadius: BorderRadius.circular(99), border: Border.all(color: const Color(0xFF47266B))), child: Text(label, style: const TextStyle(color: Color(0xFFDCCBEE), fontWeight: FontWeight.w600))); }
class _InfoCard extends StatelessWidget { const _InfoCard({required this.children}); final List<Widget> children; @override Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF14111D), borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0xFF30263E))), child: Column(children: children)); }
class _InfoRow extends StatelessWidget { const _InfoRow({required this.icon, required this.title, required this.value}); final IconData icon; final String title; final String value; @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 9), child: Row(children: [Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFF21162F), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: context.tokens.lime, size: 21)), const SizedBox(width: 12), Expanded(child: Text(title, style: const TextStyle(color: Color(0xFFAAA1B4), fontSize: 14))), Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))])); }
class _CircleButton extends StatelessWidget { const _CircleButton({required this.icon, this.onTap}); final IconData icon; final VoidCallback? onTap; @override Widget build(BuildContext context) => Material(color: const Color(0x99090712), shape: const CircleBorder(), child: InkWell(customBorder: const CircleBorder(), onTap: onTap, child: SizedBox(width: 44, height: 44, child: Icon(icon, color: Colors.white)))); }
