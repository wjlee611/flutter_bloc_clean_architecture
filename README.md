# Flutter Bloc Clean Architecture

> It's just one form of clean architecture among many, and it's meant to illustrate the architecture I've implemented, not to impose a correct answer.
>
> Feedback is always welcome.

This is the source code for a series of articles(coming soon) on [Medium (EN)]() and [my personal blog (KO)]() analyzing Flutter's clean architecture with [Bloc](https://bloclibrary.dev/).

For context on why I implemented this way, see the article above.

Similar to the [architecture guideline](https://docs.flutter.dev/app-architecture/guide) recently published by the Flutter team, and includes the following features:

- Layers, Logic separation
- Advanced cross-bloc state sharing
- Build environments separation
- API endpoints codegen
- Unit, Widget test and auto testing using github action (ci)
- Multi-device integration e2e test and take screenshots

As an example, I've implemented part of [Realworld project](https://realworld-docs.netlify.app/).

## Prerequisite

### fvm

1. Install [fvm](https://fvm.app/)
2. install SDK
   ```bash
   fvm install 3.27.3 --setup
   ```
3. Use
   ```bash
   cd <project_root>
   fvm use 3.27.3
   ```

### openapi_generator_cli (optional)

1. Install [openapi_generator_cli](https://pub.dev/packages/openapi_generator_cli) global

   ```bash
   dart pub global activate openapi_generator_cli
   ```

2. Requires path to be set for command execution
   ```bash
   # .zshrc
   export PATH="$PATH":"$HOME/.pub-cache/bin"
   ```

## Getting started

1. Initialize project dependencies

   ```bash
   fvm flutter pub get
   ```

2. Run (with flavor dev example)
   ```bash
   fvm flutter run --flavor dev -t lib/main_dev.dart
   ```

## Openapi (swagger) codegen

1. Run (Prerequisite - openapi_generator_cli)

   ```bash
   openapi-generator generate -i https://path.domain/api/open-api.json -g dart-dio -o ./lib/open_api --additional-properties=serializationLibrary=json_serializable,equalityCheckMethod=equatable
   ```

   - `-i`: Swagger open api json path
   - `-g`: Codegen templates (dart-dio)
   - `-o`: output path
   - `--additional-properties`: Additional properties (dart-dio)
     - `serializationLibrary`: JSON (de)serialization library (json_serializable)
     - `equalityCheckMethod`: Object comparison methods (equatable)

2. Modify the pubspec.yaml file to use as a monorepo

   ```yaml
   # lib/open_api/pubspec.yaml
   environment:
     sdk: ^3.6.0 # Requires SDK 3.5 or later
   # Add this
   resolution: workspace
   ```

   ```yaml
   # pubspec.yaml
   # Add this
   workspace:
     - lib/open_api
   ```

3. Run json_serializable
   ```bash
   dart run build_runner build
   ```

## How to Debug?

Check your build environment (dev/qa/prod, you can add more)

```bash
flutter run --flavor qa -t lib/main_qa.dart
```

You can change the `qa` part to a different build environment,  
or by selecting it from the Run and Debug tab in vscode.

- dev debug
- qa debug
- prod debug

> There is also an `e2e` build environment.  
> However, that environment is for integration testing, and the internal behavior is the same as `qa`, so please do not build with e2e and use it.

## How to Test?

### Unit, Widget test

1. Run command

   ```bash
   flutter test --coverage
   ```

2. Convert lcov.info to html

   ```bash
   genhtml coverage/lcov.info -o coverage/html
   ```

3. Check html for results

   ```bash
   open ./coverage/html/index.html
   ```

### Integration test

1. Check test device list at `integration_test/tools/testing_devices.dart`

2. Run command

   ```bash
   dart integration_test/script/run_tests.dart
   ```

3. Check screenshots for results

> =[Device coverage]=
>
> Pixel 1  
> Pixel 2  
> Pixel 3  
> Pixel 4  
> Pixel 5  
> Pixel 6  
> Pixel 7  
> Pixel 8  
> Pixel 9  
> iPhone SE2  
> iPhone SE3  
> iPhone 13  
> iPhone 14  
> iPhone 14 Plus  
> iPhone 15  
> iPhone 15 Pro

## CI

The Github Action CI process will automatically run when you PR or push to the main branch.
For more information, see the `.github/workflows/workflow.yml` file.

When collaborating, make sure CI passes before merging from PR creation.

Write your test code in the `/test` folder and it will be automatically tested at CI time.

Please compress the secret and upload it to Github Secret.

```bash
zip -r secrets.zip lib/core/constant/networks.dart
base64 -i secrets.zip > secrets_base64.txt
```

## Folder structure

```
📦lib
 ┃=[Features used across apps regardless of dependencies]=
 ┣ 📂core
 ┃ ┣ 📂auth
 ┃ ┃ ┗ 📂bloc
 ┃ ┃   ┣ 📜auth_bloc_singleton.dart
 ┃ ┃   ┣ 📜auth_event.dart
 ┃ ┃   ┗ 📜auth_state.dart
 ┃ ┣ 📂constant
 ┃ ┃ ┣ 📜app_consts.dart
 ┃ ┃ ┣ 📜gaps.dart
 ┃ ┃ ┣ 📜networks.dart
 ┃ ┃ ┗ 📜sizes.dart
 ┃ ┣ 📂router
 ┃ ┃ ┃=[Page route setting]=
 ┃ ┃ ┣ 📜app_router.dart
 ┃ ┃ ┗ 📜page_transition.dart
 ┃ ┗ 📂usecase
 ┃   ┣ 📜base_stream_usecase.dart
 ┃   ┗ 📜usecase_provider.dart
 ┣ 📂enum
 ┃ ┗ 📜loading_status.dart
 ┃
 ┃=[Components of the app that primarily interact with users]=
 ┣ 📂layer
 ┃ ┣ 📂data
 ┃ ┃ ┃=[Implementations of Repositories]=
 ┃ ┃ ┣ 📂repository_impl
 ┃ ┃ ┃ ┣ 📜article_repository_impl.dart
 ┃ ┃ ┃ ┣ 📜article_repository_mock_impl.dart
 ┃ ┃ ┃ ┣ 📜user_repository_impl.dart
 ┃ ┃ ┃ ┗ 📜user_repository_mock_impl.dart
 ┃ ┃ ┃=[Data providers]=
 ┃ ┃ ┗ 📂source
 ┃ ┃   ┣ 📂local
 ┃ ┃   ┃ ┣ 📜secure_storage.dart
 ┃ ┃   ┃ ┗ 📜secure_storage_impl.dart
 ┃ ┃   ┗ 📂network
 ┃ ┃     ┣ 📂interceptor
 ┃ ┃     ┃ ┗ 📜auth_interceptor.dart
 ┃ ┃     ┗ 📜app_api.dart
 ┃ ┣ 📂domain
 ┃ ┃ ┃=[Data Transfer Objects]=
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┗ 📜base_response_model.dart
 ┃ ┃ ┃=[Interface of Data Layer]=
 ┃ ┃ ┣ 📂repository
 ┃ ┃ ┃ ┣ 📜article_repository.dart
 ┃ ┃ ┃ ┗ 📜user_repository.dart
 ┃ ┃ ┃=[Repository wrapper (as needed, Optional)]=
 ┃ ┃ ┗ 📂usecase
 ┃ ┃   ┗ 📜toggle_favorite.dart
 ┃ ┗ 📂presentation
 ┃   ┃=[Page (screen)]=
 ┃   ┣ 📂home
 ┃   ┃ ┃=[Sub Page (screen)]=
 ┃   ┃ ┣ 📂article
 ┃   ┃ ┃ ┗ 📂[slug]
 ┃   ┃ ┃   ┣ 📂bloc
 ┃   ┃ ┃   ┃ ┣ 📜article_bloc.dart
 ┃   ┃ ┃   ┃ ┣ 📜article_event.dart
 ┃   ┃ ┃   ┃ ┗ 📜article_state.dart
 ┃   ┃ ┃   ┗ 📜article_page.dart
 ┃   ┃ ┃=[Business logic]=
 ┃   ┃ ┣ 📂bloc
 ┃   ┃ ┃ ┣ 📜home_bloc.dart
 ┃   ┃ ┃ ┣ 📜home_event.dart
 ┃   ┃ ┃ ┗ 📜home_state.dart
 ┃   ┃ ┣ 📂widget
 ┃   ┃ ┃ ┣ 📂favorite
 ┃   ┃ ┃ ┃ ┣ 📂bloc
 ┃   ┃ ┃ ┃ ┃ ┣ 📜favorite_bloc.dart
 ┃   ┃ ┃ ┃ ┃ ┣ 📜favorite_event.dart
 ┃   ┃ ┃ ┃ ┃ ┗ 📜favorite_state.dart
 ┃   ┃ ┃ ┃ ┗ 📜favorite_button.dart
 ┃   ┃ ┃ ┗ 📜article_card.dart
 ┃   ┃ ┃=[Presentation logic]=
 ┃   ┃ ┗ 📜home_page.dart
 ┃   ┣ 📂signin
 ┃   ┣ 📂signup
 ┃   ┗ 📂splash
 ┃
 ┃=[Openapi codegen]=
 ┣ 📂open_api
 ┃ ┣ 📂lib
 ┃ ┃ ┣ 📂src
 ┃ ┃ ┃ ┣ 📂api
 ┃ ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┣ 📜api.dart
 ┃ ┃ ┗ 📜openapi.dart
 ┃ ┗ 📜pubspec.yaml
 ┣ 📂util
 ┃ ┣ 📜app_config.dart
 ┃ ┗ 📜app_snackbar.dart
 ┃
 ┃=[App common widgets]=
 ┣ 📂widget
 ┃ ┣ 📜app_button.dart
 ┃ ┗ 📜app_text_field.dart
 ┣ 📜app.dart
 ┣ 📜flavors.dart
 ┃=[Entry point]=
 ┣ 📜main.dart
 ┃=[Flavor (Build config)]=
 ┣ 📜main_dev.dart
 ┣ 📜main_e2e.dart
 ┣ 📜main_prod.dart
 ┗ 📜main_qa.dart

📦integration_test
 ┣ 📂script
 ┃ ┃=[Multi-device e2e test script]=
 ┃ ┗ 📜run_tests.dart
 ┣ 📂tools
 ┃ ┣ 📜integration_test_driver.dart
 ┃ ┃=[Testing device list]=
 ┃ ┗ 📜testing_devices.dart
 ┃=[e2e test code]=
 ┗ 📜main_test.dart

 📦test
 ┣ 📂unit_test
 ┃ ┣ 📜article_bloc_test.dart
 ┃ ┣ 📜auth_bloc_test.dart
 ┃ ┣ 📜favorite_bloc_test.dart
 ┃ ┣ 📜home_bloc_test.dart
 ┃ ┣ 📜signin_bloc_test.dart
 ┃ ┣ 📜signup_bloc_test.dart
 ┃ ┗ 📜splash_bloc_test.dart
 ┣ 📂util
 ┃ ┗ 📜extensions.dart
 ┗ 📂widget_test
   ┣ 📜home_article_page_test.dart
   ┣ 📜home_page_test.dart
   ┣ 📜signin_page_test.dart
   ┣ 📜signup_page_test.dart
   ┣ 📜splash_page_from_auth_test.dart
   ┗ 📜splash_page_from_unauth_test.dart
```
