import 'package:material_app/controllers/bindings/my_bind.dart';

import './screens/screens.dart';
import './widgets/widgets.dart';

import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      //* for named routes
      name: AnimationsScreen.routeName,
      page: () => AnimationsScreen(),
      //* You can customize transition for different screens
      transition: Transition.zoom,
    ),
    GetPage(name: AsyncAwait.routeName, page: () => AsyncAwait()),
    GetPage(name: AuthScreen.routeName, page: () => AuthScreen()),
    GetPage(name: ButtonsDemo.routeName, page: () => ButtonsDemo()),
    GetPage(name: BlocLogin.routeName, page: () => BlocLogin()),
    GetPage(
        name: ConfirmationAcknowledgement.routeName,
        page: () => ConfirmationAcknowledgement()),
    GetPage(name: FormsDemo.routeName, page: () => FormsDemo()),
    GetPage(
        name: GridViewBuilderDemo.routeName, page: () => GridViewBuilderDemo()),
    GetPage(name: GetScreen.routeName, page: () => GetScreen()),
    //* binding to a route
    GetPage(
      name: GetDemo.routeName,
      page: () => GetDemo(),
      binding: MyBind(),
    ),
    GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
    GetPage(name: HttpDemo.routeName, page: () => HttpDemo()),
    GetPage(name: HandlingTaps.routeName, page: () => HandlingTaps()),
    GetPage(
        name: ListViewBuilderDemo.routeName, page: () => ListViewBuilderDemo()),
    GetPage(name: MapsScreen.routeName, page: () => MapsScreen()),
    GetPage(
        name: NavigationRailDemo.routeName, page: () => NavigationRailDemo()),
    GetPage(name: RowColumn.routeName, page: () => RowColumn()),
    GetPage(name: ScaffoldWidget.routeName, page: () => ScaffoldWidget()),
    GetPage(name: Screen1.routeName, page: () => Screen1()),
    GetPage(name: Screen2.routeName, page: () => Screen2()),
    GetPage(name: SharedPrefsDemo.routeName, page: () => SharedPrefsDemo()),
    GetPage(name: StreamDemo.routeName, page: () => StreamDemo()),
    GetPage(name: SlidersDemo.routeName, page: () => SlidersDemo()),
    GetPage(name: TodoScreen.routeName, page: () => TodoScreen()),
    GetPage(name: StackWidget.routeName, page: () => StackWidget()),
    GetPage(name: TabBarDemo.routeName, page: () => TabBarDemo())
  ];
}
