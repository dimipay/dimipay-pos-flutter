import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/pages/product/controller.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    if (ProductService.to.productList[barcode] == null) {
      return const SizedBox();
    }

    return Column(children: [
      const SizedBox(height: 36),
      GestureDetector(
          onTapDown: (_) {
            if (ProductPageController.to.pressedButton == "") {
              ProductPageController.to.pressedButton = "${barcode}box";
            }
          },
          onTapCancel: () => ProductPageController.to.pressedButton = "",
          onTapUp: (_) {
            ProductPageController.to.pressedButton = "";
            ProductService.to.deleteProduct(barcode);
          },
          child: Obx(() => Container(
              decoration: BoxDecoration(
                  color:
                      ProductPageController.to.pressedButton == "${barcode}box"
                          ? DPColors.grayscale300
                          : DPColors.grayscale100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: DPColors.grayscale300,
                      strokeAlign: BorderSide.strokeAlignInside)),
              padding: const EdgeInsets.all(28),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                        spacing: 6,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.start,
                        children: [
                          Text(ProductService.to.productList[barcode]!.name,
                              style: DPTypography.pos
                                  .itemTitle(color: DPColors.grayscale900)),
                          Text(
                              "${ProductService.to.productList[barcode]!.sellingPrice}원",
                              style: DPTypography.pos.itemDescription())
                        ]),
                    Wrap(
                        spacing: 32,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Obx(() => Text(
                              "${ProductService.to.productList[barcode]!.count}개",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: DPTypography.weight.medium,
                                  letterSpacing: -0.6,
                                  color: const Color.fromARGB(
                                      255, 137, 136, 128)))),
                          GestureDetector(
                              onTapDown: (_) => ProductPageController
                                  .to.pressedButton = barcode,
                              onTapCancel: () =>
                                  ProductPageController.to.pressedButton = "",
                              onTapUp: (_) {
                                ProductPageController.to.pressedButton = "";
                                ProductService.to.removeProduct(barcode);
                              },
                              child: Obx(() => Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: ProductPageController
                                                  .to.pressedButton ==
                                              barcode
                                          ? DPColors.grayscale800
                                          : DPColors.grayscale600,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const DPIcons(Symbols.remove,
                                      size: 24, color: DPColors.grayscale200))))
                        ])
                  ]))))
    ]);
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: DPColors.grayscale200,
            child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("상품을 터치해서 삭제할 수 있어요",
                            style: DPTypography.pos
                                .itemDescription(color: DPColors.grayscale500)),
                        GestureDetector(
                            onTapDown: (_) => ProductPageController
                                .to.pressedButton = "clean",
                            onTapCancel: () =>
                                ProductPageController.to.pressedButton = "",
                            onTapUp: (_) {
                              ProductPageController.to.pressedButton = "";
                              ProductService.to.clearProduct();
                            },
                            child: Obx(() => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      ProductPageController.to.pressedButton ==
                                              "clean"
                                          ? DPColors.grayscale800
                                          : DPColors.grayscale600,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text("상품 전체 삭제",
                                    style: TextStyle(
                                        color: DPColors.grayscale100,
                                        fontWeight: DPTypography.weight.medium,
                                        fontSize: 20,
                                        height: 1.25)))))
                      ]),
                  Obx(() => Column(
                      children: ProductService.to.productList.entries
                          .map((e) => ProductListItem(barcode: e.key))
                          .toList()))
                ]))));
  }
}
