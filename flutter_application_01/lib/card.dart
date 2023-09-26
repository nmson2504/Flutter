import 'package:flutter/material.dart';

/// Flutter code sample for [Card].

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Sample')),
        body: const CardExample3(),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 10),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardExample2 extends StatelessWidget {
  const CardExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // clipBehavior is necessary because, without it, the InkWell's animation
        // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
        // This comes with a small performance cost, and you should not set [clipBehavior]
        // unless you need it.
        clipBehavior: Clip.none,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: const SizedBox(
            width: 300,
            height: 100,
            child: Text('A card that can be tapped'),
          ),
        ),
      ),
    );
  }
}

class CardExample3 extends StatelessWidget {
  const CardExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(50),
          color: Color.fromARGB(255, 200, 245, 201),
          shadowColor: Color.fromARGB(255, 139, 96, 130),
          surfaceTintColor: Colors
              .amber, // trộn với color:, 3 thuộc tính color - surfaceTintColor - elevation có ảnh hưởng lẫn nhau
          elevation: 30,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shape: StadiumBorder(side: BorderSide(width: 2)), // kiểu border
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album, color: Colors.cyan, size: 45),
                title: Text(
                  "Let's Talk About Love",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Modern Talking Album'),
              ),
            ],
          ),
        ),
        // Nếu bạn muốn tuỳ biến kích thước của Card hãy đặt nó trong một Container hoặc SizedBox.
        SizedBox(
          width: 500,
          height: 200,
          child: Card(
            margin: EdgeInsets.all(50),
            color: Color.fromARGB(255, 200, 245, 201),
            shadowColor: Color.fromARGB(255, 139, 96, 130),
            surfaceTintColor: Colors
                .amber, // trộn với color:, 3 thuộc tính color - surfaceTintColor - elevation có ảnh hưởng lẫn nhau
            elevation: 50,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            //  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shape: StadiumBorder(side: BorderSide(width: 2)), // kiểu border
            /* 
            borderOnForeground của widget Card được sử dụng để xác định liệu viền của Card có được vẽ lên phần nền của các phần tử con bên trong hay không. Nếu bạn đặt borderOnForeground thành true, viền của Card sẽ được vẽ đè lên nền của các phần tử con. Nếu bạn đặt nó thành false, nền của các phần tử con sẽ được đè lên phía trên viền của Card. (phải set màu nền, viền cho các object liên quan mới test được)
             */
            borderOnForeground: false, //
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTileTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Color.fromARGB(255, 79, 22, 236), width: 2.0),
                  ),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 243, 33, 180),
                    leading: Icon(Icons.album, color: Colors.cyan, size: 45),
                    title: Text(
                      "Let's Talk About Love",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('Modern Talking Album'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// demo 3 example
class CardExamplesApp extends StatelessWidget {
  const CardExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Spacer(),
        ElevatedCardExample(),
        FilledCardExample(),
        OutlinedCardExample(),
        Spacer(),
      ],
    );
  }
}

/* 
Để có hiệu ứng trên card phải set tại MaterialApp như dưới đây:
theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
 */
/// The default settings for [Card] will provide an elevated
/// card matching the spec:
///
/// https://m3.material.io/components/cards/specs#a012d40d-7a5c-4b07-8740-491dec79d58b
class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 200,
          height: 100,
          child: Center(child: Text('Elevated Card')),
        ),
      ),
    );
  }
}

/// To make a [Card] match the filled type, the default elevation and color
/// need to be changed to the values from the spec:
///
/// https://m3.material.io/components/cards/specs#0f55bf62-edf2-4619-b00d-b9ed462f2c5a
class FilledCardExample extends StatelessWidget {
  const FilledCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 200,
          height: 100,
          child: Center(child: Text('Filled Card')),
        ),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 200,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}
