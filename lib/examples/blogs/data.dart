class BlogPost {
  final int id;
  final String title;
  final String excerpt;
  final String content;
  final String author;
  final DateTime date;

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.author,
    required this.date,
  });
}

List<BlogPost> dummyBlogs1 = [
  BlogPost(
    id: 1,
    title: "Flutter Web",
    excerpt: "Building web apps with Flutter",
    content: "Detailed content about building web apps with Flutter...",
    author: "Jane Doe",
    date: DateTime(2024, 7, 15),
  ),
  BlogPost(
    id: 2,
    title: "Dart Basics",
    excerpt: "Introduction to Dart programming",
    content: "In-depth guide to Dart programming basics...",
    author: "John Smith",
    date: DateTime(2024, 7, 18),
  ),
  BlogPost(
    id: 3,
    title: "State Management",
    excerpt: "Different state management approaches in Flutter",
    content: "Exploration of various state management solutions in Flutter...",
    author: "Alice Johnson",
    date: DateTime(2024, 7, 20),
  ),
  BlogPost(
    id: 4,
    title: "Effective Debugging",
    excerpt: "Tips and tricks for debugging Flutter apps",
    content:
        "Effective debugging is a critical skill for Flutter developers. This post covers various tools and techniques for debugging Flutter applications...",
    author: "Jane Doe",
    date: DateTime(2024, 7, 22),
  ),
  BlogPost(
    id: 5,
    title: "Animations in Flutter",
    excerpt: "Creating beautiful animations in Flutter",
    content:
        "Animations can greatly enhance the user experience in a Flutter app. This post explores how to create various types of animations in Flutter...",
    author: "John Smith",
    date: DateTime(2024, 7, 24),
  ),
];

List<BlogPost> dummyBlogs = [
  BlogPost(
    id: 1,
    title: "Flutter Web",
    excerpt: "Building web apps with Flutter",
    content: """
Flutter, originally known for mobile app development, has expanded its horizons to web development. With Flutter Web, developers can create highly interactive and responsive web applications using the same codebase they use for mobile apps. This blog post covers the basics of setting up Flutter for web development, creating responsive layouts, and deploying web apps.

### Getting Started
To get started with Flutter Web, you need to have Flutter installed on your machine. You can enable web support by running:
```
flutter config --enable-web
flutter create my_flutter_web_app
cd my_flutter_web_app
flutter run -d chrome
```
This will create a new Flutter project and run it on the Chrome browser.

### Creating Responsive Layouts
Creating responsive layouts in Flutter is straightforward. You can use widgets like `LayoutBuilder` and `MediaQuery` to adjust the UI based on the screen size. Here's an example:
```dart
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return DesktopLayout();
      } else {
        return MobileLayout();
      }
    },
  );
}
```

### Deploying Flutter Web Apps
Deploying Flutter Web apps is easy. You can build the web app using:
```
flutter build web
```
This command generates the necessary files in the `build/web` directory. You can then deploy these files to any web server, like Firebase Hosting, GitHub Pages, or Netlify.

### Conclusion
Flutter Web provides a seamless way to create web applications with the same codebase as mobile apps. With its rich set of widgets and tools, you can build highly interactive and responsive web apps quickly and efficiently.
""",
    author: "Jane Doe",
    date: DateTime(2024, 7, 15),
  ),
  BlogPost(
    id: 2,
    title: "Dart Basics",
    excerpt: "Introduction to Dart programming",
    content: """
Dart is a client-optimized programming language for developing fast apps on multiple platforms. It is the language behind Flutter and is known for its simplicity and performance. This blog post covers the basics of Dart programming, including syntax, data types, control flow, and functions.

### Syntax
Dart syntax is easy to learn, especially if you have experience with other programming languages like JavaScript or Java. Here is a simple Dart program:
```dart
void main() {
  print('Hello, Dart!');
}
```
This program prints "Hello, Dart!" to the console.

### Data Types
Dart supports various data types, including integers, doubles, booleans, strings, and lists. Here are some examples:
```dart
int age = 30;
double height = 5.9;
bool isStudent = false;
String name = 'John Doe';
List<int> scores = [85, 90, 88];
```

### Control Flow
Dart supports standard control flow statements like if-else, for loops, and while loops. Here is an example:
```dart
void main() {
  int score = 85;
  if (score > 90) {
    print('Excellent');
  } else if (score > 75) {
    print('Good');
  } else {
    print('Needs Improvement');
  }
}
```

### Functions
Functions in Dart are similar to those in other programming languages. Here is an example of a function that calculates the area of a rectangle:
```dart
double calculateArea(double width, double height) {
  return width * height;
}

void main() {
  double area = calculateArea(5.0, 3.0);
  print('Area: \$area');
}
```

### Conclusion
Dart is a powerful and easy-to-learn language that is perfect for developing fast and responsive apps. By understanding the basics of Dart programming, you can start building your own applications with confidence.
""",
    author: "John Smith",
    date: DateTime(2024, 7, 18),
  ),
  BlogPost(
    id: 3,
    title: "State Management",
    excerpt: "Different state management approaches in Flutter",
    content: """
State management is a crucial aspect of developing Flutter applications. It involves managing the state of the app and ensuring that the UI reflects the current state accurately. This blog post explores different state management solutions in Flutter, including setState, Provider, and Bloc.

### setState
The simplest way to manage state in Flutter is by using the setState method. It is used to update the state of a widget and rebuild the UI. Here is an example:
```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \$_count'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### Provider
Provider is a popular state management solution in Flutter. It is based on the InheritedWidget and makes it easy to share state across the app. Here is an example:
```dart
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Provider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Counter>(
                builder: (context, counter, child) => Text('Count: \${counter.count}'),
              ),
              ElevatedButton(
                onPressed: () => context.read<Counter>().increment(),
                child: Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Bloc
Bloc is a more advanced state management solution that uses the BLoC (Business Logic Component) pattern. It helps to separate business logic from the UI and makes the code more testable and maintainable. Here is an example:
```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield state + 1;
    }
  }
}

void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Bloc Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CounterBloc, int>(
                builder: (context, count) => Text('Count: \$count'),
              ),
              ElevatedButton(
                onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
                child: Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}
```

### Conclusion
There are various state management solutions available in Flutter, each with its own advantages and use cases. By understanding the different approaches, you can choose the one that best suits your application's needs.
""",
    author: "Alice Johnson",
    date: DateTime(2024, 7, 20),
  ),
  BlogPost(
    id: 4,
    title: "Effective Debugging",
    excerpt: "Tips and tricks for debugging Flutter apps",
    content: """
Effective debugging is a critical skill for Flutter developers. It helps to identify and fix issues quickly, ensuring a smooth user experience. This blog post covers various tools and techniques for debugging Flutter applications.

### Debugging Tools
Flutter provides several built-in tools for debugging, including:
- Dart DevTools: A suite of debugging and profiling tools for Dart and Flutter.
- Flutter Inspector: A powerful tool for visualizing and exploring Flutter widget trees.
- Logging: Using print statements to log information to the console.

### Using Dart DevTools
Dart DevTools can be accessed from the command line or directly from your IDE. It provides features like:
- Widget Inspector: Inspect the widget tree and view widget properties.
- Timeline: Analyze performance and identify slow frames.
- Memory: Monitor memory usage and identify memory leaks.

### Common Debugging Techniques
Here are some common debugging techniques in Flutter:
- Print Statements: Adding print statements to log information.
- Breakpoints: Setting breakpoints in your code to pause execution and inspect variables.
- Assertions: Using assert statements to validate assumptions in your code.

### Debugging Layout Issues
Layout issues can be challenging to debug. Here are some tips:
- Using the Flutter Inspector to visualize the widget tree.
- Checking constraints and sizes using the LayoutBuilder widget.
- Using the debugPaintSizeEnabled flag to visualize widget boundaries.



### Debugging Performance Issues
Performance issues can significantly impact the user experience. Here are some tips:
- Using the Timeline in Dart DevTools to identify slow frames.
- Profiling your app to identify performance bottlenecks.
- Optimizing expensive operations and avoiding unnecessary rebuilds.

### Conclusion
Effective debugging is essential for developing high-quality Flutter applications. By using the available tools and techniques, you can quickly identify and fix issues, ensuring a smooth user experience.
""",
    author: "Jane Doe",
    date: DateTime(2024, 7, 22),
  ),
  BlogPost(
    id: 5,
    title: "Animations in Flutter",
    excerpt: "Creating beautiful animations in Flutter",
    content: """
Animations can greatly enhance the user experience in a Flutter app. They can make the app feel more dynamic and responsive. This blog post explores how to create various types of animations in Flutter, including implicit and explicit animations.

### Implicit Animations
Implicit animations are easy to use and are automatically animated when their properties change. Here is an example using the AnimatedContainer widget:
```dart
class AnimatedBox extends StatefulWidget {
  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  bool _isExpanded = false;

  void _toggleBox() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBox,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: _isExpanded ? 200 : 100,
        height: _isExpanded ? 200 : 100,
        color: _isExpanded ? Colors.blue : Colors.red,
        child: Center(child: Text('Tap me')),
      ),
    );
  }
}
```
In this example, the box animates its size and color when tapped.

### Explicit Animations
Explicit animations provide more control over the animation process. Here is an example using the AnimationController and Tween:
```dart
class ExplicitAnimation extends StatefulWidget {
  @override
  _ExplicitAnimationState createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Center(child: Text('Hello, Flutter!')),
        );
      },
    );
  }
}
```
In this example, the text fades in using an explicit animation.

### Using Animation Widgets
Flutter provides several animation widgets, including:
- AnimatedOpacity: Animate the opacity of a widget.
- AnimatedPositioned: Animate the position of a widget.
- AnimatedSize: Animate the size of a widget.

### Conclusion
Animations can greatly enhance the user experience in a Flutter app. By understanding implicit and explicit animations, you can create dynamic and responsive UI elements that engage users.
""",
    author: "John Smith",
    date: DateTime(2024, 7, 24),
  ),
];
