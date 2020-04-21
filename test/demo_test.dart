import 'package:flutter_test/flutter_test.dart';
import 'package:testapp/view/test/demo.dart';

void main() {
  
  test('test hello', (){
    var str = HelloTest.greet('nihao');
    expect(str, 'hello');
  });
  
}
