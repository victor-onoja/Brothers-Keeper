import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/widgets/button.dart';
import '../../onboard/notifier/metamask.dart';

class MPW extends StatefulWidget {
  const MPW({super.key});

  @override
  State<MPW> createState() => _MPWState();
}

class _MPWState extends State<MPW> {
  bool isHover5 = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => MetaMaskProvider()..init(),
        builder: (context, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.large(
              onPressed: () {},
              tooltip: 'List new NFT',
              backgroundColor: AppColors.bgcolor.shade400,
              child: Icon(
                Icons.add,
                color: AppColors.green.shade100,
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  'assets/images/bklog.png'),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 28),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  'assets/images/bklog.png'),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  MediaQuery.of(context).size.width > 650
                                      ? Text(
                                          'BROTHER\'SKEEPER\nMARKETPLACE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.start,
                                        )
                                      : Text(
                                          'BK\nMARKETPLACE',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textAlign: TextAlign.start,
                                        ),
                                ],
                              )),
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
                        ]),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'list an NFT...',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    ),
                    MediaQuery.of(context).size.width > 650
                        ? Column(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Container(
                                    height: 400,
                                    width: 215,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white)),
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.bgcolor.shade400,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: AppColors.error,
                                              ),
                                              tooltip: 'Cancel NFT',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              18.0, 0, 18, 18),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                'assets/images/nft.jpg',
                                                fit: BoxFit.fill,
                                                height: 200,
                                                width: 200,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'desc: An NFT worth having',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.monetization_on,
                                                  color: AppColors
                                                      .bgcolor.shade400,
                                                ),
                                                label: Text(
                                                  'BUY',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColors.green
                                                                .shade100)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Container(
                                    height: 400,
                                    width: 215,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white)),
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.bgcolor.shade400,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: AppColors.error,
                                              ),
                                              tooltip: 'Cancel NFT',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              18.0, 0, 18, 18),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                'assets/images/nft.jpg',
                                                fit: BoxFit.fill,
                                                height: 200,
                                                width: 200,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'desc: An NFT worth having',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.monetization_on,
                                                  color: AppColors
                                                      .bgcolor.shade400,
                                                ),
                                                label: Text(
                                                  'BUY',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColors.green
                                                                .shade100)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Container(
                                    height: 400,
                                    width: 215,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white)),
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.bgcolor.shade400,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: AppColors.error,
                                              ),
                                              tooltip: 'Cancel NFT',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              18.0, 0, 18, 18),
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                'assets/images/nft.jpg',
                                                fit: BoxFit.fill,
                                                height: 200,
                                                width: 200,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'desc: An NFT worth having',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.monetization_on,
                                                  color: AppColors
                                                      .bgcolor.shade400,
                                                ),
                                                label: Text(
                                                  'BUY',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColors.green
                                                                .shade100)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])
                        : Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Container(
                                      height: 400,
                                      width: 215,
                                      decoration: BoxDecoration(
                                        border: const Border(
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            top:
                                                BorderSide(color: Colors.white),
                                            left:
                                                BorderSide(color: Colors.white),
                                            right: BorderSide(
                                                color: Colors.white)),
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.bgcolor.shade400,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.cancel,
                                                  color: AppColors.error,
                                                ),
                                                tooltip: 'Cancel NFT',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                18.0, 0, 18, 18),
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  'assets/images/nft.jpg',
                                                  fit: BoxFit.fill,
                                                  height: 200,
                                                  width: 200,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              'desc: An NFT worth having',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: ElevatedButton.icon(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.monetization_on,
                                                    color: AppColors
                                                        .bgcolor.shade400,
                                                  ),
                                                  label: Text(
                                                    'BUY',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppColors
                                                                  .green
                                                                  .shade100)),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Container(
                            height: 400,
                            width: 215,
                            decoration: BoxDecoration(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.white),
                                  top: BorderSide(color: Colors.white),
                                  left: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white)),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.bgcolor.shade400,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: AppColors.error,
                                      ),
                                      tooltip: 'Cancel NFT',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      18.0, 0, 18, 18),
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/images/nft.jpg',
                                        fit: BoxFit.fill,
                                        height: 200,
                                        width: 200,
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'desc: An NFT worth having',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.monetization_on,
                                          color: AppColors.bgcolor.shade400,
                                        ),
                                        label: Text(
                                          'BUY',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.green.shade100)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
