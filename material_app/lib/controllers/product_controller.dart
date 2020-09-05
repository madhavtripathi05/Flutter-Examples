import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  //* Reactive Model (RxProduct)
  final product = Product().obs;

  //* just add .obs to any Type to make it an
  //* Observable, or you can alternatively use:
  final string = Rx<String>();

  //* for controlling textFields
  TextEditingController titleController;
  TextEditingController priceController;

  @override
  void onInit() {
    //*  onInit is automatically called when
    //* controller is initialized like initState()
    titleController = TextEditingController();
    priceController = TextEditingController();

    //* Workers will assist you in triggering specific callbacks,
    //* when an event occurs, can only be used with Streams.

    //* will be called every time the product is changed
    ever(product, (_) => print('product: ${_.title} updated'));

    //* will be called only first time the product is changed
    once(product, (_) => print('product: ${_.title} updated once'));

    //* Anti DDos - Called every time the user stops typing for 1 second
    debounce(product, (_) => print('got product: ${_.title} after 1 second'),
        time: Duration(seconds: 1));

    //* Ignore all changes within 1 second.
    interval(product, (_) => print('ignored product: ${_.title}'),
        time: Duration(seconds: 1));

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    //* onClose is called when this controller is removed
    //* from the memory, dispose off your streams here.
    titleController?.dispose();
    priceController?.dispose();
    super.onClose();
  }

  updateProduct() {
    product.update((value) {
      //* (here) value holds your current state
      value.title = titleController.text;
      value.price = double.tryParse(priceController.text) ?? 0.0;
      value.id ??= DateTime.now().millisecondsSinceEpoch;
    });
  }
}
