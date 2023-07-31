import 'package:flutter/material.dart';

class MyVirtualKeyboard extends StatelessWidget {
  const MyVirtualKeyboard({
    super.key,
    required this.callbackWhole,
    required this.callbackDecimal,
    required this.backspace,
    required this.setDecimalMode,
    required this.isDecimalMode,
    required this.isEmpty,
  });

  final Function callbackWhole;
  final Function callbackDecimal;
  final Function backspace;
  final Function setDecimalMode;
  final bool isDecimalMode;
  final bool isEmpty;

  Widget button(Widget icon, BuildContext context, Function function) {
    return SizedBox(
      height: MediaQuery.of(
            context,
          ).size.height /
          10,
      width: MediaQuery.of(
            context,
          ).size.width /
          3,
      child: InkWell(
        onTap: () => function(),
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fontSize = 35.0;
    const keys = [
      [
        '1',
        '2',
        '3',
      ],
      [
        '4',
        '5',
        '6',
      ],
      [
        '7',
        '8',
        '9',
      ],
    ];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...keys
                .map(
                  (row) => Row(
                    children: row
                        .map(
                          (e) => button(
                            Center(
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                            context,
                            () {
                              if (isDecimalMode) {
                                callbackDecimal(
                                  e,
                                );
                              } else {
                                callbackWhole(
                                  e,
                                );
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
            Row(
              children: [
                button(
                  const Center(
                    child: Text(
                      '.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  context,
                  () {
                    if (!isDecimalMode) {
                      if (!isEmpty) {
                        setDecimalMode();
                      }
                      callbackDecimal(
                        '.',
                      );
                    }
                  },
                ),
                button(
                  const Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  context,
                  () {
                    if (isDecimalMode) {
                      callbackDecimal(
                        '0',
                      );
                    } else {
                      callbackWhole(
                        '0',
                      );
                    }
                  },
                ),
                button(
                  const Icon(
                    Icons.backspace,
                  ),
                  context,
                  backspace,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
