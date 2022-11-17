import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/widgets/button.dart';

class POPupT extends StatefulWidget {
  const POPupT({
    super.key,
  });

  @override
  State<POPupT> createState() => _POPupTState();
}

class _POPupTState extends State<POPupT> {
  bool isHover9 = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: AppColors.bgcolor.shade400,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Column(children: [
              Text(
                'data',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: const Border(
                        bottom: BorderSide(color: AppColors.green),
                        top: BorderSide(color: AppColors.green),
                        left: BorderSide(color: AppColors.green),
                        right: BorderSide(color: AppColors.green)),
                    borderRadius: BorderRadius.circular(12)),
                child: AppButton(
                    onHover: (valu) {
                      setState(() {
                        isHover9 = valu;
                      });
                    },
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Done',
                    icon: Icon(
                      Icons.done_sharp,
                      color: isHover9
                          ? AppColors.green.shade500
                          : AppColors.green.shade100,
                    ),
                    textStyle: MediaQuery.of(context).size.width > 650
                        ? isHover9
                            ? Theme.of(context).textTheme.headline6
                            : Theme.of(context).textTheme.headline2
                        : isHover9
                            ? Theme.of(context).textTheme.headline5
                            : Theme.of(context).textTheme.headline4),
              )
            ])));
  }
}
