import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/models/prodect.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: GoogleFonts.alef(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            //color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // image: NetworkImage(widget.product.imageLink)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.product.imageLink,
                  fit: BoxFit.fill,
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Text(
                  'Price :',
                  style: GoogleFonts.alef(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  '${widget.product.price} \$',
                  style: GoogleFonts.alef(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Category :',
                  style: GoogleFonts.alef(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  widget.product.cateogry.name,
                  style: GoogleFonts.alef(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Rate :',
                      style: GoogleFonts.alef(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.product.rate.toStringAsFixed(1),
                      style: GoogleFonts.alef(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final selectedRate = await showDialog<int>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Rate This Product'),
                            content: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  final rate = index + 1;
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context, rate);
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          child: Text('$rate'),
                                        ),
                                      )
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     Navigator.pop(context,
                                      //         rate); // Return the selected number
                                      //   },
                                      //   child: Text('$rate'),
                                      // ),
                                      );
                                }),
                              ),
                            ),
                          );
                        },
                      );

                      if (selectedRate != null) {
                        setState(() {
                          widget.product.rateTheProduct(selectedRate);
                        });
                      }
                    },
                    child: const Text('Rate This Product'))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Descreption',
              style: GoogleFonts.alef(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.product.descreption,
                style: GoogleFonts.alef(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
