# Copilot instructions

## Project location and commands

The Flutter application is in `restaurante_visual/` (the Git repository root is its parent). Run Flutter and Dart commands from that application directory:

```sh
cd restaurante_visual
flutter pub get
flutter analyze
flutter test
flutter test test/widget_test.dart
flutter test test/widget_test.dart --plain-name 'Test básico para compilar sin errores'
dart format lib test
dart format lib/pantallas/pantalla_mesero.dart
flutter build web
```

Firebase Hosting is configured to serve `build/web`; after building, deploy it with `firebase deploy --only hosting` when the Firebase CLI is configured for the intended project.

## Application structure

- `lib/main.dart` initializes Firebase with `DefaultFirebaseOptions.currentPlatform`, sets the Material theme, and opens `LoginScreen`.
- `lib/pantallas/` contains the role and workflow screens. `login_screen.dart` routes to gerente, mesero, cocina, or bulk-loading flows; the screens navigate with Flutter routes rather than a separate router or state-management package.
- Firestore is the shared application data layer, accessed directly by screens with `FirebaseFirestore.instance`. `StreamBuilder` is used for live lists; screen actions write documents and batches directly.
- The main shared Firestore collections are `productos`, `recetas`, `insumos`, `comandas`, `compras`, `proveedores`, `configuracion`, and `informes_produccion`. Workflows cross screen boundaries: order entry and inventory deduction affect kitchen, cashier, and accounting views; purchases and configuration are also read by accounting.
- `lib/responsive.dart` centralizes width breakpoints (600 and 1024 px), grid column selection, and page padding. `lib/ui/brand.dart` centralizes the shared palette, radius, panel decoration, and primary button style.
- Firebase platform configuration is in `lib/firebase_options.dart`, `.firebaserc`, and the platform-specific Firebase files. Hosting rewrites client routes to `index.html` in `firebase.json`.

## Repository-specific conventions

- Keep the UI and domain vocabulary in Spanish, matching existing screen names (`Pantalla...`), labels, and identifiers.
- Screens currently own their Firestore queries and writes and commonly shape records as `Map<String, dynamic>`. Before changing a collection’s fields, trace both its writers and every screen that reads it; preserve existing field names and status values unless updating the full workflow.
- Keep shared responsive layout and brand styling in `Responsive` and `Brand` rather than introducing screen-specific alternatives for common behavior.
- `analysis_options.yaml` enables `flutter_lints` and excludes generated platform/build directories. Keep application changes in `lib/`; avoid editing generated Flutter or Firebase platform files unless the task specifically concerns platform setup.
- The current widget test is a minimal smoke test. Run `flutter test` after changes and add focused tests alongside it when changing behavior.
