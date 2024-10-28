# Local Fx

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Simple Forex Flutter app

---

## Running the app 🚀

* Clone this repository
* Run ``flutter pub get``

This project contains 3 flavors:

- production
- staging
- development

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Production
$ flutter run --flavor production --target lib/main_production.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Development
$ flutter run --flavor development --target lib/main_development.dart

```

_\*Local Fx works on iOS, and Android._

---

## App distribution 📦

Download the apk here:

- [Firebase App Distribution][app_distribution_link]

---

## Running Tests 🧪

To run all tests use the following command: 

```sh
$ flutter test
```

---

## Notes 📝

Firebase Remote Config was used to inject the API keys for our forex providers as it offers a layer of protection beyond the standard practice of directly bundling keys with the app. Ideally, a more secure and isolated architecture would involve complete decoupling, with all third-party API interactions occurring server-side, either through a dedicated backend or a cloud function setup. However, given the relatively light operational scope of this project, Firebase Remote Config provides a balance between security and simplicity, aligning with the project’s requirements while reducing overhead.


[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[app_distribution_link]: https://appdistribution.firebase.dev/i/5e08ecfe4e784ff3