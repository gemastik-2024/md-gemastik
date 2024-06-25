import 'package:get/get.dart';

import '../modules/cognitive_failure/bindings/cognitive_failure_binding.dart';
import '../modules/cognitive_failure/views/cognitive_failure_view.dart';
import '../modules/cognitive_games/bindings/cognitive_games_binding.dart';
import '../modules/cognitive_games/views/cognitive_games_view.dart';
import '../modules/community/bindings/community_binding.dart';
import '../modules/community/views/community_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/medical_history/bindings/medical_history_binding.dart';
import '../modules/medical_history/views/medical_history_view.dart';
import '../modules/menus/menu_item_one/bindings/menu_item_one_binding.dart';
import '../modules/menus/menu_item_one/views/menu_item_one_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/socio_demographic/bindings/socio_demographic_binding.dart';
import '../modules/socio_demographic/views/socio_demographic_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ON_BOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COGNITIVE_FAILURE,
      page: () => const CognitiveFailureView(),
      binding: CognitiveFailureBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY,
      page: () => const CommunityView(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: _Paths.MENU_ITEM_ONE,
      page: () => MenuItemOneView(),
      binding: MenuItemOneBinding(),
    ),
    GetPage(
      name: _Paths.SOCIO_DEMOGRAPHIC,
      page: () => const SocioDemographicView(),
      binding: SocioDemographicBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_HISTORY,
      page: () => const MedicalHistoryView(),
      binding: MedicalHistoryBinding(),
    ),
    GetPage(
      name: _Paths.COGNITIVE_GAMES,
      page: () => const CognitiveGamesView(),
      binding: CognitiveGamesBinding(),
    ),
  ];
}
