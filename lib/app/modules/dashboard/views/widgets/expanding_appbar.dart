// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/constans.dart';

class ExpandingAppBarController extends GetxController {
  final Rx<RoundedHeaderState> _state = RoundedHeaderState().obs;

  RoundedHeaderState get state => _state.value;

  updateHeight(double currentHeight) {
    final newState = RoundedHeaderState(currentHeight: currentHeight);

    if (_state.value.currentHeight != newState.currentHeight) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _state.value = newState;
      });
    }
    debugPrint("updateHeight");
  }
}

class ExpandingAppBar extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const ExpandingAppBar({
    Key? key,
    this.children = const <Widget>[],
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpandingAppBarController());

    return Obx(
      () {
        final state = controller.state;

        return SliverAppBar(
          expandedHeight: state.highestHeight,
          pinned: true,
          backgroundColor: darkBlueColor,
          primary: true,
          forceElevated: true,
          /* title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Text(
              "Akson",
              style: GoogleFonts.sourceSerif4(
                  fontSize: 30, color: Color.fromARGB(255, 236, 236, 236)),
            ),
          ]),
        ),
       */
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(state.radius)),
          ),
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              controller.updateHeight(constraints.maxHeight);

              return Opacity(
                opacity: state.scrollFraction,
                child: Padding(
                  padding: EdgeInsets.only(top: state.smallestHeight),
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    children: children,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

@immutable
class RoundedHeaderState {
  final double highestHeight = 200;
  final double smallestHeight = kToolbarHeight + 24;
  final double currentHeight;
  final double contentOpacity = 1;

  RoundedHeaderState({this.currentHeight = 256});

  double get scrollFraction => min(
      max((currentHeight - smallestHeight) / (highestHeight - smallestHeight),
          0),
      1);
  double get radius => 130 * scrollFraction;
}
