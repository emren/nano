import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nano/ui/pages/product_page.dart';
import 'package:provider/provider.dart';

import '../../core/providers/store_provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    var storeProvider = Provider.of<StoreProvider>(context, listen: false);
    storeProvider.fetchStoreAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
        appBar: storeAppBar(),
        body: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            reverse: false,
            scrollDirection: Axis.vertical,
            itemCount: storeProvider.storeAds.length,
            itemBuilder: (context, index) {
              return storeAdWidget(context, storeProvider, index);
            },
          ),
        ),
        bottomNavigationBar: bottomNavigationItems());
  }

  AppBar storeAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[10],
      title: const Text('All Products',
          style:
              TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }

  ClipRRect bottomNavigationItems() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: BottomNavigationBar(backgroundColor: Colors.white10, items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/cart.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              semanticLabel: '',
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/like.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              semanticLabel: '',
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/user.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              semanticLabel: '',
            ),
            label: ''),
      ]),
    );
  }

  Column storeAdWidget(
      BuildContext context, StoreProvider storeProvider, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(index: index),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.grey[20],
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  Center(
                    child: Image.network(storeProvider.storeAds[index].image!,
                        fit: BoxFit.fitWidth),
                  ),
                  AlignPositioned(
                    alignment: Alignment.bottomCenter,
                    dx: -100,
                    dy: -10,
                    child: Text(
                      '${storeProvider.storeAds[index].price!} AED',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'SF Pro Display',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  AlignPositioned(
                      alignment: Alignment.bottomCenter,
                      dx: 100,
                      dy: -10,
                      child: RatingBar.builder(
                        itemSize: 25,
                        initialRating: storeProvider
                            .storeAds[index].rating!.rate!
                            .toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      )),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Text(
            'product name',
            style: TextStyle(
                fontFamily: 'Open Sans',
                color: Colors.grey,
                fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            storeProvider.storeAds[index].description!,
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 10,
                color: Colors.black,
                fontStyle: FontStyle.normal),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
