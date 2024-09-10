import 'package:e_commerce_app/controller/cartscreen_controller.dart';
import 'package:e_commerce_app/view/cartscreen/widget/cart_item.dart';
import 'package:e_commerce_app/view/utils/colorconstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CartscreenController>().getAllCartItems();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          backgroundColor: ColorConstants.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorConstants.white,
              )),
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        body: Consumer<CartscreenController>(
          builder: (context, cartProv, child) {
            final totalAmount = cartProv.calculateTotalAmount();
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      cartProv.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final cartItem = cartProv
                                        .getCurrentItem(cartProv.keys[index]);
                                    return CartItem(
                                      title: cartItem?.title ?? "",
                                      qty: cartItem?.qty ?? 0,
                                      price: cartItem?.price ?? 0,
                                      image: cartItem?.image ?? "",
                                      onDecrement: () {
                                        context
                                            .read<CartscreenController>()
                                            .decrementQnty(
                                                cartProv.keys[index]);
                                      },
                                      onIncrement: () {
                                        context
                                            .read<CartscreenController>()
                                            .incrementQnty(
                                                cartProv.keys[index]);
                                      },
                                      onRemove: () {
                                        context
                                            .read<CartscreenController>()
                                            .removeCartItem(
                                                cartProv.keys[index]);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: cartProv.keys.length))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 80,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total :",
                              style: TextStyle(
                                  color: ColorConstants.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              "${totalAmount.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: ColorConstants.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColorConstants.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            );
          },
        ));
  }
}
