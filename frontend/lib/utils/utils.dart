void checkThen(bool Function() checkFunction, Function callback) {
  if (!checkFunction()) {
    return;
  }

  callback();
}

void asyncCheckThen(
    Future<bool> Function() checkFunction, Function callback) async {
  if (!(await checkFunction())) {
    return;
  }

  callback();
}
