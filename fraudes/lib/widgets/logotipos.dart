import 'package:flutter/material.dart';

class LogotiposWidget extends StatelessWidget {
  const LogotiposWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  'assets/images/gobierno.png',
                  fit: BoxFit.fitHeight,
                  height: 48,
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/ssp.png',
                fit: BoxFit.fitHeight,
                height: 48,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/c5.png',
                fit: BoxFit.fitHeight,
                height: 36,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/089.png',
                fit: BoxFit.fitHeight,
                height: 36,
              ),
            ),
            // Expanded(
            //   child: Image.asset(
            //     'assets/images/ucibernetica.png',
            //     fit: BoxFit.fitHeight,
            //     height: 39,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
