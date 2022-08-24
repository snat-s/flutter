// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Test for wrap that generates children and checks if they are layed out',
      (WidgetTester tester) async {
    final List<Widget> children = List<Widget>.generate(
      10,
      (int index) => SizedBox(
        height: index.isEven ? 100 : 50,
        width: index.isEven ? 95 : 180,
        child: Center(child: Text('Item $index')),
      ),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GridView.wrap(
          children: children,
        ),
      ),
    ));
    for (int i = 0; i < 9; i++) {
      expect(find.text('Item $i'), findsOneWidget);
    }
  });

  testWidgets('Test for wrap to be laying child dynamically',
      (WidgetTester tester) async {
    final List<Widget> children = List<Widget>.generate(
      20,
      (int index) => SizedBox(
        height: index.isEven ? 1000 : 50,
        width: index.isEven ? 95 : 180,
        child: Center(child: Text('Item $index')),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GridView.builder(
              itemCount: children.length,
              gridDelegate: const SliverGridDelegateWithWrapping(),
              itemBuilder: (BuildContext context, int index) =>
                  children[index]),
        ),
      ),
    );
    for (int i = 0; i < 5; i++) {
      expect(find.text('Item $i'), findsOneWidget);
    }
    expect(find.text('Item 5'), findsNothing);
    await tester.scrollUntilVisible(find.text('Item 19'), 500.0);
    await tester.pumpAndSettle();
    expect(find.text('Item 18'), findsOneWidget);
    expect(find.text('Item 0'), findsNothing);
    expect(find.text('Item 1'), findsNothing);
  });
  // TODO(snat-s): create this test
  // testWidgets('Test for wrap if it wraps', (WidgetTester tester) async {
  //   final List<Widget> children = List<Widget>.generate(
  //     20,
  //     (int index) => SizedBox(
  //       height: index.isEven ? 100 : 50,
  //       width: index.isEven ? 100 : 180,
  //       child: Center(child: Text('Item $index')),
  //     ),
  //   );
  //   // Change the size of the screen
  //   tester.binding.window.physicalSizeTestValue = Size(500, 100);

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: Scaffold(
  //       body: GridView.builder(
  //           itemCount: children.length,
  //             gridDelegate: const SliverGridDelegateWithWrapping(),
  //             itemBuilder: (BuildContext context, int index) => children[index]
  //           ),
  //       ),
  //     ),
  //   );
  //   // await tester.pumpAndSettle();
  //   for(int i = 0; i < 3; i++) {
  //      expect(find.text('Item $i'), findsOneWidget);
  //   }
  //   expect(find.text('Item 4'), findsNothing);

  //   // resets the screen to its original size after the test end
  //   addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  // });
//   // TODO(snat-s): create this test
//   testWidgets('Test wrap to see nothing affected if random elements are deleted', (WidgetTester tester) async {
//     final List<Widget> children = List<Widget>.generate(
//       150,
//       (int index) => Container(
//         height: index.isEven ? 1000 : 50,
//         width: index.isEven ? 95 : 180,
//         child: Center(child: Text('Item $index')),
//       ),
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithWrapping(),
//               itemBuilder: (BuildContext context, int index) => children[index]),
//         ),
//       ),
//     );
//   });
//   // TODO(snat-s): create this test
//   testWidgets('Test wrap for layouts that go from left to right instead of right to left', (WidgetTester tester) async {
//     final List<Widget> children = List<Widget>.generate(
//       150,
//       (int index) => Container(
//         height: index.isEven ? 1000 : 50,
//         width: index.isEven ? 95 : 180,
//         child: Center(child: Text('Item $index')),
//       ),
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithWrapping(),
//               itemBuilder: (BuildContext context, int index) => children[index]),
//         ),
//       ),
//     );
//   });
//   // TODO(snat-s): create this test
//   testWidgets('Test wrap for layouts that go from left to right instead of right to left', (WidgetTester tester) async {
//     final List<Widget> children = List<Widget>.generate(
//       150,
//       (int index) => Container(
//         height: index.isEven ? 1000 : 50,
//         width: index.isEven ? 95 : 180,
//         child: Center(child: Text('Item $index')),
//       ),
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithWrapping(),
//               itemBuilder: (BuildContext context, int index) => children[index]),
//         ),
//       ),
//     );
//   });
//   // TODO(snat-s): create this test
testWidgets('Test for GridView.wrap to scrollDirection Axis.horizontal', (WidgetTester tester) async {
    final List<Widget> children = List<Widget>.generate(
      20,
      (int index) => SizedBox(
        height: index.isEven ? 100 : 50,
        width: index.isEven ? 100 : 180,
        child: Center(child: Text('Item $index')),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GridView.wrap(
            scrollDirection: Axis.horizontal,
            children: children,
          ),
        ),
      ),
    );
    for (int i = 0; i < 20; i++) {
      expect(find.text('Item $i'), findsOneWidget);
    }
  });
//   // TODO(snat-s): create this test
//   testWidgets('Check for screen readers and that they process the grid correctly', (WidgetTester tester) async {
//     final List<Widget> children = List<Widget>.generate(
//       150,
//       (int index) => Container(
//         height: index.isEven ? 1000 : 50,
//         width: index.isEven ? 95 : 180,
//         child: Center(child: Text('Item $index')),
//       ),
//     );

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithWrapping(),
//               itemBuilder: (BuildContext context, int index) => children[index]),
//         ),
//       ),
//     );
//   });
  testWidgets('Test GridView.builder for GridView.reverse to true',
      (WidgetTester tester) async {
    final List<Widget> children = List<Widget>.generate(
      20,
      (int index) => SizedBox(
        height: index.isEven ? 100 : 50,
        width: index.isEven ? 100 : 180,
        child: Center(child: Text('Item $index')),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GridView.builder(
              reverse: true,
              itemCount: children.length,
              gridDelegate: const SliverGridDelegateWithWrapping(),
              itemBuilder: (BuildContext context, int index) => children[index]),
        ),
      ),
    );
    for (int i = 0; i < 20; i++) {
      expect(find.text('Item 0'), findsOneWidget);
    }
  });
  testWidgets('Test GridView.wrap for GridView.reverse to true',
      (WidgetTester tester) async {
    final List<Widget> children = List<Widget>.generate(
      20,
      (int index) => SizedBox(
        height: index.isEven ? 100 : 50,
        width: index.isEven ? 100 : 180,
        child: Center(child: Text('Item $index')),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GridView.wrap(
            reverse: true,
            children: children,
          ),
        ),
      ),
    );
    for (int i = 0; i < 20; i++) {
      expect(find.text('Item 0'), findsOneWidget);
    }
  });
}
