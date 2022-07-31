import 'package:chart_test/data.dart';
import 'package:chart_test/points.dart';

generateYPoints(number) {
  yCoordinates.add(number);
  while (number > 1) {
    if (number % 2 == 0) {
      number /= 2;
    } else {
      number = (number * 3) + 1;
    }
    yCoordinates.add(number);

    if (number > yMax) yMax = number.toInt();
    count++;
  }
}

generatePoints() {
  for (int i = 0; i < yCoordinates.length; i++) {
    points.add(
      Point(
        x: double.parse(i.toString()),
        y: double.parse(
          yCoordinates[i].toString(),
        ),
      ),
    );
  }
}

printYPoint(Point p) {
  return p.y.toInt();
}
