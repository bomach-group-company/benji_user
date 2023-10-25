import 'package:flutter/material.dart';

Future<void> myScrollLoader(
    ScrollController scrollController,
    Future<dynamic> Function(int start, int end) fetchFunc,
    int start,
    int end) async {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    dynamic data = await fetchFunc(start, end);
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 25),
      curve: Curves.easeInOut,
    );
    return data;
    // await _getData();

    // setState(() {
    //   loadMore = false;
    // });
  }
}
