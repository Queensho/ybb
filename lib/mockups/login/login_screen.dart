import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: _HeroArea(),
            ),
            Expanded(
              flex: 6,
              child: _LoginPanel(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.tokens.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary,
            context.colors.primaryContainer,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 8,
            top: 28,
            child: _GlowBubble(size: 86),
          ),
          Positioned(
            right: 14,
            bottom: 22,
            child: _GlowBubble(size: 64),
          ),
          Transform.rotate(
            angle: -0.12,
            child: Container(
              width: 150,
              height: 205,
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(context.tokens.radiusLg),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 28,
                    offset: const Offset(0, 16),
                    color: context.colors.shadow.withOpacity(.28),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: context.tokens.lime,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 38,
                    color: context.colors.onSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBubble extends StatelessWidget {
  const _GlowBubble({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.tokens.lime.withOpacity(.9),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 4,
            color: context.tokens.lime.withOpacity(.22),
          ),
        ],
      ),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        context.tokens.spaceLg,
        context.tokens.spaceXl,
        context.tokens.spaceLg,
        context.tokens.spaceLg,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.tokens.radiusLg),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giriş yap',
              style: context.texts.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: context.tokens.spaceSm),
            Text(
              'Telefon numaranızla devam edin',
              style: context.texts.titleLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.tokens.spaceXs),
            Text(
              'Ülkenizi seçin ve cep telefonu numaranızı girin.',
              style: context.texts.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.tokens.spaceLg),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Cep telefonu numarası',
                hintText: '5xx xxx xx xx',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: context.tokens.spaceMd),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🇹🇷', style: TextStyle(fontSize: 22)),
                      SizedBox(width: context.tokens.spaceSm),
                      Text(
                        '+90',
                        style: context.texts.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: context.tokens.spaceSm),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: context.tokens.spaceMd),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.tokens.lime,
                  foregroundColor: context.colors.onSecondary,
                ),
                onPressed: () {},
                child: const Text('Doğrulama kodu gönder'),
              ),
            ),
            SizedBox(height: context.tokens.spaceMd),
            Row(
              children: [
                Expanded(child: Divider(color: context.colors.outlineVariant)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.tokens.spaceSm),
                  child: Text(
                    'VEYA',
                    style: context.texts.labelSmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: context.colors.outlineVariant)),
              ],
            ),
            SizedBox(height: context.tokens.spaceMd),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                label: const Text('Başka bir yöntemle giriş yap'),
              ),
            ),
            SizedBox(height: context.tokens.spaceLg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 18,
                  color: context.tokens.lime,
                ),
                SizedBox(width: context.tokens.spaceSm),
                Expanded(
                  child: Text(
                    'Numaranız güvende. Bilgileriniz asla paylaşılmaz.',
                    style: context.texts.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
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
