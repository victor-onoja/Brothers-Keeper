import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/widgets/button.dart';
import '../../onboard/notifier/metamask.dart';

class OpenIssues extends StatefulWidget {
  const OpenIssues({super.key});

  @override
  State<OpenIssues> createState() => _OpenIssuesState();
}

class _OpenIssuesState extends State<OpenIssues> {
  bool isHover5 = false;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => MetaMaskProvider()..init(),
        builder: (context, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MediaQuery.of(context).size.width > 650
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/bklog.png'),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 28),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/bklog.png'),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            MediaQuery.of(context).size.width > 650
                                ? Text(
                                    'BROTHER\'SKEEPER',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.start,
                                  )
                                : Text(
                                    'BROTHER\'SKEEPER',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.start,
                                  ),
                          ],
                        )),
                        Consumer<MetaMaskProvider>(builder:
                            (BuildContext context, value, Widget? child) {
                          String text = '';
                          Color color = AppColors.green.shade100;

                          if (value.isConnected && value.isInOperatingChain) {
                            text = value.currentAddress;
                          } else if (value.isConnected &&
                              !value.isInOperatingChain) {
                            return Text('Please connect to goerli test net',
                                style: MediaQuery.of(context).size.width > 650
                                    ? GoogleFonts.spaceMono(
                                        fontSize: 28, color: AppColors.error)
                                    : GoogleFonts.spaceMono(
                                        fontSize: 14, color: AppColors.error));
                          } else if (value.isEnabled) {
                            context
                                .read<MetaMaskProvider>()
                                .checkForConnection();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: const Border(
                                        bottom:
                                            BorderSide(color: AppColors.green),
                                        top: BorderSide(color: AppColors.green),
                                        left:
                                            BorderSide(color: AppColors.green),
                                        right:
                                            BorderSide(color: AppColors.green)),
                                    borderRadius: BorderRadius.circular(12)),
                                child: AppButton(
                                    onHover: (val) {
                                      setState(() {
                                        isHover5 = val;
                                      });
                                    },
                                    onPressed: () => context
                                        .read<MetaMaskProvider>()
                                        .connect(),
                                    text: 'CONNECT WALLET',
                                    icon: Icon(
                                      Icons.wallet,
                                      color: isHover5
                                          ? AppColors.green.shade500
                                          : AppColors.green.shade100,
                                    ),
                                    textStyle:
                                        MediaQuery.of(context).size.width > 650
                                            ? isHover5
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                            : isHover5
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                              ),
                            );
                          } else {
                            return Text('Please use a web3 enabled browser',
                                style: MediaQuery.of(context).size.width > 650
                                    ? GoogleFonts.spaceMono(
                                        fontSize: 28, color: AppColors.error)
                                    : GoogleFonts.spaceMono(
                                        fontSize: 14, color: AppColors.error));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: AppColors.green),
                                          top: BorderSide(
                                              color: AppColors.green),
                                          left: BorderSide(
                                              color: AppColors.green),
                                          right: BorderSide(
                                              color: AppColors.green)),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    text,
                                    style:
                                        MediaQuery.of(context).size.width > 650
                                            ? GoogleFonts.spaceMono(
                                                fontSize: 28, color: color)
                                            : GoogleFonts.spaceMono(
                                                fontSize: 14, color: color),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ]),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Opened Issues',
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          IconButton(
                            tooltip: 'filter',
                            icon: const Icon(
                              Icons.filter_alt,
                              color: AppColors.green,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                  MediaQuery.of(context).size.width > 650
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28, 0, 0, 10),
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  selectedTileColor: AppColors.bgcolor.shade400,
                                  leading: Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.green.shade100,
                                  ),
                                  title: Container(
                                      child: Text(
                                    'How to, How to, How to',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28, 0, 0, 10),
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  selectedTileColor: AppColors.bgcolor.shade400,
                                  leading: Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.green.shade100,
                                  ),
                                  title: Container(
                                      child: Text(
                                    'How to, How to, How to',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                  )),
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28, 0, 0, 10),
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  selectedTileColor: AppColors.bgcolor.shade400,
                                  leading: Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.green.shade100,
                                  ),
                                  title: Container(
                                      child: Text(
                                    'How to, How to, How to',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28, 0, 0, 10),
                              child: InkWell(
                                onTap: () {},
                                child: ListTile(
                                  selectedTileColor: AppColors.bgcolor.shade400,
                                  leading: Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.green.shade100,
                                  ),
                                  title: Container(
                                      child: Text(
                                    'How to, How to, How to',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
          );
        });
  }
}
