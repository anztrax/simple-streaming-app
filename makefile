## =====================
## start app
## =====================

run_dev:
	@flutter run --flavor development -t lib/main_app_dev.dart

run_prod:
	@flutter run --flavor production -t lib/main_app_prod.dart

run_staging:
	@flutter run --flavor staging -t lib/main_app_staging.dart

build_prod_apk:
	@flutter clean
	@flutter build apk --release --flavor production -t lib/main_app_prod.dart

build_prod_appbundle:
	@flutter clean
	@flutter build appbundle --flavor production -t lib/main_app_prod.dart