import 'package:benji_user/frontend/store/category.dart';
import 'package:benji_user/src/frontend/utils/constant.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';

class MyDropDown extends StatefulWidget {
  final bool visible;
  final List<Category> items;

  const MyDropDown({super.key, required this.visible, required this.items});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  bool isHover = false;
  List isHoverList = [];

  @override
  void initState() {
    super.initState();
    isHoverList = List.generate(widget.items.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      // child: Scrollbar(
      //   thumbVisibility: true,
      //   interactive: true,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 40 *
              (widget.items.length < 5 ? widget.items.length : 5).toDouble(),
        ),
        width: 200,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widget.items.length + 2,
          itemBuilder: (context, index) {
            return index == 0 || index == widget.items.length + 1
                ? kHalfSizedBox
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (event) {
                      setState(() {
                        isHoverList[index - 1] = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        isHoverList[index - 1] = false;
                      });
                    },
                    child: Container(
                      color: isHoverList[index - 1]
                          ? Colors.black12
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return CategoryPage(
                                  activeCategoriesId:
                                      widget.items[index - 1].id,
                                  activeCategories:
                                      widget.items[index - 1].name,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          widget.items[index - 1].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
      // ),
    );
  }
}
