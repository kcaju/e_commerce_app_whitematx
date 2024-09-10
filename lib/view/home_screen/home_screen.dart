import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/controller/cartscreen_controller.dart';
import 'package:e_commerce_app/controller/homescreen_controller.dart';
import 'package:e_commerce_app/view/cartscreen/cart_screen.dart';
import 'package:e_commerce_app/view/home_screen/widget/product_card.dart';
import 'package:e_commerce_app/view/productdetails_screen/productdetails_screen.dart';
import 'package:e_commerce_app/view/utils/colorconstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          backgroundColor: ColorConstants.black,
          leading: Icon(
            Icons.menu,
            color: ColorConstants.white,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: ColorConstants.white,
                size: 35,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Consumer<HomescreenController>(
          builder: (context, newArrivalProv, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "New Arrivals",
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                  items: List.generate(
                    newArrivalProv.newArrivals.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductdetailsScreen(
                                  title: newArrivalProv.newArrivals[index]
                                      ['title'],
                                  des: newArrivalProv.newArrivals[index]
                                      ['description'],
                                  image: newArrivalProv.newArrivals[index]
                                      ['image'],
                                  rate: newArrivalProv.newArrivals[index]
                                      ['rating'],
                                  price: newArrivalProv.newArrivals[index]
                                      ['price'],
                                  id: newArrivalProv.newArrivals[index]['id'],
                                ),
                              ));
                        },
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      newArrivalProv.newArrivals[index]
                                          ['image'])),
                              color: ColorConstants.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 250,
                    viewportFraction: 1.0,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Explore Products",
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          itemCount: newArrivalProv.allProducts.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 400,
                                  mainAxisSpacing: 15),
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductdetailsScreen(
                                          id: newArrivalProv.allProducts[index]
                                              ['id'],
                                          title: newArrivalProv
                                              .allProducts[index]['title'],
                                          des: newArrivalProv.allProducts[index]
                                              ['description'],
                                          image: newArrivalProv
                                              .allProducts[index]['image'],
                                          rate: newArrivalProv
                                              .allProducts[index]['rating'],
                                          price: newArrivalProv
                                              .allProducts[index]['price']),
                                    ));
                              },
                              child: ProductCard(
                                  toAdd: () {
                                    context
                                        .read<CartscreenController>()
                                        .addCartItem(
                                          title: newArrivalProv
                                              .allProducts[index]['title'],
                                          price: newArrivalProv
                                              .allProducts[index]['price'],
                                          des: newArrivalProv.allProducts[index]
                                              ['description'],
                                          id: newArrivalProv.allProducts[index]
                                              ['id'],
                                          image: newArrivalProv
                                              .allProducts[index]['image'],
                                        )
                                        .then(
                                      (value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen(),
                                            ));
                                      },
                                    );
                                  },
                                  title: newArrivalProv.allProducts[index]
                                      ['title'],
                                  price: newArrivalProv.allProducts[index]
                                      ['price'],
                                  img: newArrivalProv.allProducts[index]
                                      ['image'])),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: ColorConstants.white),
                ),
              ))
            ],
          ),
        ));
  }
}
