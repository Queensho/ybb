# YBB UX Mockup

Bu repo YBB mobil uygulamasının UX/UI mockup deposudur. Ana uygulamanın business logic, Riverpod provider, navigation ve backend kodlarını içermez.

## Tasarım sistemi

- Material 3
- Primary: elektrik moru `#7C2CFF`
- Accent: lime `#B7FF2A`
- Açık ve koyu tema
- Tema erişimi: `context.colors`, `context.texts`, `context.tokens`, `context.theme`, `context.isDark`
- Ortak boşluk, radius ve semantik renkler `AppTokens` içindedir.

## İlk ekran

`lib/mockups/login/login_screen.dart`

Telefonla giriş ekranının çalışan görsel mockup'ıdır. Üst bölüm mor 3D/illustrative hero, alt bölüm koyu Material yüzey, lime CTA ve mor odak durumlarından oluşur.

## Gerçek uygulamaya giydirme talimatı

Mockup ekranını gerçek uygulamaya taşırken mevcut işlevleri, state yönetimini, Riverpod provider'larını, navigation yapısını ve doğrulama akışını koru. Yalnızca layout, tipografi, spacing, radius, tema renkleri ve görsel bileşenleri mockup'taki tasarıma göre uygula. Gerçek uygulamada bulunan `lib/core/theme/app_theme.dart`, `app_tokens.dart`, `theme_controller.dart`, `context_ext.dart` altyapısını koru ve paralel tema sistemi oluşturma.
