// const String baseFrontendUrl = 'https://resource.bgbot.app/api/v1/frontend';
const String baseFrontendUrl = 'https://benji-app.onrender.com/api/v1/frontend';

// const String mediaBaseFrontendUrl = 'https://resource.bgbot.app';
const String mediaBaseFrontendUrl = 'https://benji-app.onrender.com';

const double laptopSize = 992;
const double tabletSize = 768;
const double mobileSize = 576;

const double laptopContainer = 50;
const double tabletContainer = 50;
const double mobileContainer = 25;

// nice looking red but not our red 0xff059542
// nice looking blue but not our blue 0xff2d2942

double breakPoint(double size, double mobile, double tablet, double laptop) {
  if (size <= mobileSize) {
    return mobile;
  } else if (size <= laptopSize) {
    return tablet;
  } else {
    return laptop;
  }
}

dynamic breakPointDynamic(
    dynamic size, dynamic mobile, dynamic tablet, dynamic laptop) {
  if (size <= mobileSize) {
    return mobile;
  } else if (size <= laptopSize) {
    return tablet;
  } else {
    return laptop;
  }
}

dynamic deviceType(dynamic size) {
  if (size <= mobileSize) {
    return 1;
  } else if (size <= laptopSize) {
    return 2;
  } else {
    return 3;
  }
}

double responsiveSize(
    {required double size,
    double start = 0,
    double end = 0,
    required List<double> points}) {
  if (end == 0) {
    double result = breakPoint(size, 1, 2, 3);
    if (result == 1) {
      start = 280;
      end = mobileSize;
    } else if (result == 2) {
      start = mobileSize;
      end = laptopSize;
    } else {
      start = laptopSize;
      end = 1500;
    }
  }

  int length = points.length;
  double update = (end - start) * (1 / length) + 1;
  int index = 0;
  double current = start;
  while (current <= end && current + update <= end) {
    current += update;
    if (size < current) {
      return points[index];
    }
    index++;
  }
  return points[length - 1];
}

double responsiveNumberSize(double size, List<double> points) {
  double start;
  double end;

  double result = breakPoint(size, 1, 2, 3);
  if (result == 1) {
    start = 280;
    end = mobileSize;
  } else if (result == 2) {
    start = mobileSize;
    end = laptopSize;
  } else {
    start = laptopSize;
    end = 1500;
  }

  int length = points.length;
  double update = (end - start) * (1 / length) + 1;
  int index = 0;
  double current = start;
  while (current <= end && current + update <= end) {
    current += update;
    if (size < current) {
      return points[index];
    }
    index++;
  }
  return points[length - 1];
}
