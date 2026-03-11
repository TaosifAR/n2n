import 'dart:isolate';
import 'package:flutter_test/flutter_test.dart';
import 'package:n2n/main.dart';

void main() {
  testWidgets('System monitoring smoke test', (WidgetTester tester) async {
    // ১. একটি নকল ReceivePort তৈরি করা কারণ MyApp এটি চায়
    final receivePort = ReceivePort();

    // ২. আমাদের নতুন MyApp বিল্ড করা
    await tester.pumpWidget(MyApp(receivePort: receivePort));

    // ৩. চেক করা যে স্ক্রিনে স্বাগতম মেসেজটি আছে কি না (Normal State)
    // দ্রষ্টব্য: শুরুতে SystemInitial থাকে, তাই কিছুটা অপেক্ষা করতে হতে পারে
    expect(find.textContaining('n2n'), findsWidgets);
    
    receivePort.close(); // টেস্ট শেষে পোর্ট বন্ধ করা
  });
}