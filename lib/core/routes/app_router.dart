// import 'package:flutter/cupertino.dart';
//
// import 'route_names.dart';
// import 'route_paths.dart';
//
// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();
//
// final GoRouter appRouter = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   observers: [MyNavigatorObserver()],
//   initialLocation: RoutePaths.splash,
//   routes: [
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (context, state, child) => MainPage(child: child),
//       routes: [
//         // *   Profile
//         GoRoute(
//           path: RoutePaths.profile,
//           name: RouteNames.profile,
//           parentNavigatorKey: _shellNavigatorKey,
//           builder: (context, state) => const ProfilePage(),
//           routes: <RouteBase>[
//             GoRoute(
//               path: RoutePaths.profileInviteFriends,
//               name: RouteNames.profileInviteFriends,
//               parentNavigatorKey: _rootNavigatorKey,
//               builder: (context, state) => const ProfileInviteFriendsPage(),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
//
// class MyNavigatorObserver extends NavigatorObserver {
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     logger.i('did push route $route');
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     logger.i('did pop route $route');
//   }
// }
