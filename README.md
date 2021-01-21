# Simple Streaming App

Supported devices android
```
min : android 6.0 (M) (v23)
```
Supported features
```
1. search music
2. start / stop music
3. offline / online network status indicator
```

Requirements:
```
at least Flutter version 1.23.0-18.1.pre
```

Before you run the app
```
flutter pub get
```

How to run:
1. Dev environment
    ```
    make run_dev
    ```
2. Staging enviroment
    ```
    make run_staging
    ```
3. Production enviroment
    ```
    make run_prod
    ```

how to build prod app:
1. Build APK
    ```
    make build_prod_apk
    ```
2. Build appbundle
    ```
    make build_prod_appbundle
    ```