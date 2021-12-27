import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';

class BenefitsSection extends StatefulWidget {
  @override
  _BenefitsSectionState createState() => _BenefitsSectionState();
}

class _BenefitsSectionState extends State<BenefitsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GymStore>(
      builder: (context, store, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.spaceEvenly,
              children: store.selectedGymDetail.data.benefits
                  .map((e) => IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: e.image != null
                                    ? Image.network(e.image)
                                    : Container(),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Text(
                                e.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
