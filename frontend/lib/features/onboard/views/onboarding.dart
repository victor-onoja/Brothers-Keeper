import 'package:brothers_keeper/core/constants/colors.dart';
import 'package:brothers_keeper/core/constants/widgets/button.dart';
import 'package:brothers_keeper/features/home/views/home.dart';
import 'package:brothers_keeper/features/marketplace/views/marketplace.dart';
import 'package:brothers_keeper/features/onboard/viewsattach/popup_t.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../notifier/metamask.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  bool isHover = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover5 = false;
  bool isHover6 = false;
  bool isHover7 = false;
  bool isHover8 = false;
  bool isHover9 = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MetaMaskProvider()..init(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.bgcolor.shade400,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.6,
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/bgroundimg.jpg'),
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
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
                                        isHover9 = val;
                                      });
                                    },
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MarketPlace()));
                                    },
                                    text: 'Market Place',
                                    icon: Icon(
                                      Icons.store_mall_directory,
                                      color: isHover9
                                          ? AppColors.green.shade500
                                          : AppColors.green.shade100,
                                    ),
                                    textStyle:
                                        MediaQuery.of(context).size.width > 650
                                            ? isHover9
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                            : isHover9
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Consumer<MetaMaskProvider>(builder:
                                  (BuildContext context, value, Widget? child) {
                                String text = '';
                                Color color = AppColors.green.shade100;

                                if (value.isConnected &&
                                    value.isInOperatingChain) {
                                  text = value.currentAddress;
                                } else if (value.isConnected &&
                                    !value.isInOperatingChain) {
                                  return Text(
                                      'Please connect to goerli test net',
                                      style: MediaQuery.of(context).size.width >
                                              650
                                          ? GoogleFonts.spaceMono(
                                              fontSize: 28,
                                              color: AppColors.error)
                                          : GoogleFonts.spaceMono(
                                              fontSize: 14,
                                              color: AppColors.error));
                                } else if (value.isEnabled) {
                                  context
                                      .read<MetaMaskProvider>()
                                      .checkForConnection();
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
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
                                          textStyle: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  650
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
                                  return Text(
                                      'Please use a web3 enabled browser',
                                      style: MediaQuery.of(context).size.width >
                                              650
                                          ? GoogleFonts.spaceMono(
                                              fontSize: 28,
                                              color: AppColors.error)
                                          : GoogleFonts.spaceMono(
                                              fontSize: 14,
                                              color: AppColors.error));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 24.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
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
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          text,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  650
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.125,
                          ),
                          MediaQuery.of(context).size.width > 650
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.125),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/bklog.png'),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 28),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/bklog.png'),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          MediaQuery.of(context).size.width > 650
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.125),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BROTHER\'S',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'KEEPER',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BROTHER\'S',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'KEEPER',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          MediaQuery.of(context).size.width > 650
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.125,
                                      left: MediaQuery.of(context).size.width *
                                          0.125),
                                  child: Text(
                                    'A Decentralized, Autonomous, Organisation that rewards you for contributing to world peace, green future, world poverty alleviation, and much more, you decide...',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    'A Decentralized, Autonomous, Organisation that rewards you for contributing to world peace, green future, world poverty alleviation, and much more, you decide...',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.start,
                                  ),
                                )
                        ])),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.6,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bgroundimg.jpg'),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MediaQuery.of(context).size.width > 650
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24.0),
                                        child: Text(
                                          'JOIN US',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24.0),
                                        child: Text(
                                          'JOIN US',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                'A Decentralized, Autonomous, Organisation that rewards you for contributing to world peace, green future, world poverty alleviation, and much more, you decide...',
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: AppButton(
                                        onHover: (val) {
                                          setState(() {
                                            isHover = val;
                                          });
                                        },
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePge()));
                                        },
                                        text: 'MINT',
                                        icon: Icon(
                                          Icons.monetization_on,
                                          color: isHover
                                              ? AppColors.green.shade500
                                              : AppColors.green.shade100,
                                        ),
                                        textStyle:
                                            MediaQuery.of(context).size.width >
                                                    650
                                                ? isHover
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                : isHover
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                ),
                                Image.asset('assets/images/bklog.png')
                              ])),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.6,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bgroundimg.jpg'),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                ),
                                Image.asset('assets/images/bklog.png')
                              ])),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MediaQuery.of(context).size.width > 650
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24.0),
                                        child: Text(
                                          'EXPLORE MARKETPLACE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          'EXPLORE MARKETPLACE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                'A Decentralized, Autonomous, Organisation that rewards you for contributing to world peace, green future, world poverty alleviation, and much more, you decide...',
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: AppButton(
                                        onHover: (val) {
                                          setState(() {
                                            isHover9 = val;
                                          });
                                        },
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MarketPlace()));
                                        },
                                        text: 'HERE',
                                        icon: Icon(
                                          Icons.store_mall_directory,
                                          color: isHover9
                                              ? AppColors.green.shade500
                                              : AppColors.green.shade100,
                                        ),
                                        textStyle:
                                            MediaQuery.of(context).size.width >
                                                    650
                                                ? isHover9
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                : isHover9
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.6,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bgroundimg.jpg'),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MediaQuery.of(context).size.width > 650
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24.0),
                                        child: Text(
                                          'ABOUT US',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24.0),
                                        child: Text(
                                          'ABOUT US',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                'A Decentralized, Autonomous, Organisation that rewards you for contributing to world peace, green future, world poverty alleviation, and much more, you decide...',
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: AppButton(
                                        onHover: (val) {
                                          setState(() {
                                            isHover2 = val;
                                          });
                                        },
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const POPupT());
                                        },
                                        text: 'READ',
                                        icon: Icon(
                                          Icons.file_open,
                                          color: isHover2
                                              ? AppColors.green.shade500
                                              : AppColors.green.shade100,
                                        ),
                                        textStyle:
                                            MediaQuery.of(context).size.width >
                                                    650
                                                ? isHover2
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                : isHover2
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                ),
                                Image.asset('assets/images/bklog.png')
                              ])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
