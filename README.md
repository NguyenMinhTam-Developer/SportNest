# Clean and refesh project: 
- clear && flutter clean && flutter pub get && cd ios && pod install && cd .. && clear

# Generate Assets & Models: 
- flutter pub run build_runner build --delete-conflicting-outputs

# Generate Locales:
- flutter pub global activate get_cli && export PATH="$PATH":"$HOME/.pub-cache/bin" && get generate locales assets/locales
- flutter pub global activate get_cli
- export PATH="$PATH":"$HOME/.pub-cache/bin"
- get generate locales assets/locales

# Initialize Firebase CLI
- dart pub global activate flutterfire_cli
- export PATH="$PATH":"$HOME/.pub-cache/bin"
- flutterfire configure

# Build
- flutter build apk --release && flutter build appbundle --release
- flutter build apk --release
- flutter build appbundle --release

# Generate Launcher Icons
- dart run flutter_launcher_icons