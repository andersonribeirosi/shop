import 'package:flutter/cupertino.dart';

class CounterState {
  int _value = 0;
  int get value => _value;

  void inc() => _value++;
  void dec() => _value--;
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();
  CounterProvider(Widget child, {Key? key}) : super(key: key, child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
