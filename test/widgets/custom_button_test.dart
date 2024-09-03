import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';

void main() {
  testWidgets('PrimaryButton widget renders correctly with default properties',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Button Label',
            onPressed: () {},
          ),
        ),
      ),
    );

    // Check if the text is rendered correctly
    expect(find.text('Button Label'), findsOneWidget);

    // Check if ElevatedButton is used when isLoading is false
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Ensure no loading indicator is shown
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Tapping PrimaryButton calls onPressed callback',
      (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Button Label',
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Button Label'));
    await tester.pumpAndSettle();

    // Verify the onPressed callback was called
    expect(onPressedCalled, true);
  });

  testWidgets(
      'PrimaryButton shows CircularProgressIndicator when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Loading Button',
            isLoading: true,
            onPressed: () {},
          ),
        ),
      ),
    );

    // Ensure the CircularProgressIndicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Ensure no ElevatedButton is displayed when loading
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('PrimaryButton with custom background color and label color',
      (WidgetTester tester) async {
    const Color customBackgroundColor = Colors.red;
    const Color customLabelColor = Colors.yellow;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Colored Button',
            onPressed: () {},
            backgroundColor: customBackgroundColor,
            labelColor: customLabelColor,
          ),
        ),
      ),
    );

    // Verify ElevatedButton's background color
    ElevatedButton button =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.style!.backgroundColor!.resolve({}), customBackgroundColor);

    // Verify Text color
    Text textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style!.color, customLabelColor);
  });

  testWidgets('PrimaryButton is outlined when isOutlined is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Outlined Button',
            onPressed: () {},
            isOutlined: true,
            labelColor: Colors.green,
          ),
        ),
      ),
    );

    // Verify the button's border color
    ElevatedButton button =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    RoundedRectangleBorder shape =
        button.style!.shape!.resolve({}) as RoundedRectangleBorder;
    expect(shape.side.color, Colors.green);
  });
}
