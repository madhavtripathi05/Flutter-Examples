import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import 'package:dartx/dartx.dart';

class ProductController extends GetxController {
  //* Reactive Object (RxProduct)
  final product = Product().obs;
  TextEditingController titleController;
  TextEditingController priceController;

  @override
  void onInit() {
    titleController = TextEditingController();
    priceController = TextEditingController();

    //* Workers will assist you in triggering specific callbacks,
    //* when an event occurs, can only be used with Streams.

    //* will be called every time the product is changed
    ever(product, (_) => print('product: ${_.title} updated'));

    //* will be called only first time the product is changed
    once(product, (_) => print('product: ${_.title} updated once'));

    //* Anti DDos - Called every time the user stops typing for 1 second
    debounce(product, (_) => print('got product: ${_.title} after 1 seconds'),
        time: 1.seconds);

    //* Ignore all changes within 1 second.
    interval(product, (_) => print('ignored product: ${_.title}'),
        time: 1.seconds);

    super.onInit();
  }

  @override
  void onClose() {
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
