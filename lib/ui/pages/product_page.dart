import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../core/providers/store_provider.dart';
import '../theme/palette.dart';

class ProductPage extends StatefulWidget {
  final int index;
  const ProductPage({super.key, required this.index});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int get index => widget.index;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    orderProduct(context, index);
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Center(
                child: Image.network(storeProvider.storeAds[index].image!,
                    fit: BoxFit.fitWidth),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: const EdgeInsets.only(left: 20.0),
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.arrow_back),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 20.0),
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              AlignPositioned(
                alignment: Alignment.topLeft,
                dy: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future orderProduct(context, int index) async {
    var storeProvider = Provider.of<StoreProvider>(context);
    bool isOpen = true;
    await showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, state) {
            return Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      isOpen = !isOpen;

                      state(() {
                        setState(() {});
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: 40,
                          width: 40,
                          child: const Icon(Icons.arrow_drop_down,
                              color: Palette.light_blue),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/share.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        width: 270,
                        height: 65,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Palette.light_blue),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: const BorderSide(
                                          color: Palette.light_blue)))),
                          onPressed: () {},
                          child: const Text(
                            'Order Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          'Description',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          maxLines: 5,
                          storeProvider.storeAds[index].description!,
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isOpen
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reviews (${storeProvider.storeAds[index].rating?.count!})',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${storeProvider.storeAds[index].rating?.rate!}',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: storeProvider
                                        .storeAds[index].rating!.rate!
                                        .toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
