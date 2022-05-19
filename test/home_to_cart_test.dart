import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/favs/favs_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_auth/main.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_auth/Screens/cart/cart_screen.dart';
import 'package:flutter_auth/Screens/cart/components/check_out_card.dart';
import 'package:flutter_auth/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_auth/enums.dart';
import 'package:flutter_auth/Screens/Home/components/icon_btn_with_counter.dart';
import 'package:flutter_auth/Screens/Home/components/home_header.dart';

import 'navigation_test.mocks.dart';

// @GenerateMocks(
//   [],
//   customMocks: [
//     MockSpec<NavigatorObserver>(
//       returnNullOnMissingStub: true,
//     )
//   ],
// )
void main() {
  testWidgets('Button is present and triggers navigation after tapped',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: HomeHeader(),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byType(IconBtnWithCounter), findsOneWidget);
    await tester.tap(find.byType(IconBtnWithCounter));
    await tester.pumpAndSettle();

    /// Verify that a push event happened
    verify(mockObserver.didPush(any, any));

    /// You'd also want to be sure that your page is now
    /// present in the screen.
    expect(find.byType(CartScreen), findsOneWidget);
  });
}
