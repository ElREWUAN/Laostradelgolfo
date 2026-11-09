# Conectar la app a TU Firebase (La Ostra del Golfo)

## 1. Herramientas (una sola vez)
```
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login          # inicia sesión con TU cuenta de Google
```

## 2. Reconfigurar el proyecto
Desde la carpeta `restaurante_visual`:
```
flutterfire configure
```
Elige tu proyecto **Laostradelgolfo** y las plataformas (android, ios, web).
Esto REEMPLAZA automáticamente:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `firebase.json`

Después edita `.firebaserc` y cambia `mr-pulpo-pos` por el ID de tu proyecto
(el ID aparece en Firebase → Configuración → General → "ID del proyecto").

## 3. Crear Firestore
Firebase → Bases de datos y almacenamiento → Firestore Database → Crear base de datos.

Reglas (pestaña "Reglas"). La app NO usa Firebase Authentication (el acceso es por PIN),
así que necesita permitir lectura/escritura. Esto es TEMPORAL y cualquiera con tu
configuración podría leer/escribir; el modo de prueba expira a los 30 días y la app dejaría de funcionar:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

## 4. Cargar el menú
```
flutter pub get
flutter run
```
En la pantalla de acceso escribe el código **999** → botón
**CARGAR MENÚ LA OSTRA DEL GOLFO**. Se crean todos los productos en la colección `productos`.
