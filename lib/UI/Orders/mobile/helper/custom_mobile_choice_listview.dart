import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/repository/order/model/hive_order_model.dart';
import '../../../utils/theme/text_class.dart';

class CustomMobileChoiceListview extends ConsumerStatefulWidget {
  const CustomMobileChoiceListview({super.key});

  @override
  ConsumerState<CustomMobileChoiceListview> createState() =>
      _CustomMobileChoiceListviewState();
}

class _CustomMobileChoiceListviewState
    extends ConsumerState<CustomMobileChoiceListview> {
  OrderStatus? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(width: 10),
        ChoiceChip(
          label: Text(TextClass.all),
          selected: selectedFilter == null,
          onSelected: (bool selected) {
            setState(() {
              selectedFilter = null;
            });
          },
        ),
        const SizedBox(width: 10),
        ...OrderStatus.values.map((status) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ChoiceChip(
              label: Text(status.name),
              selected: selectedFilter == status,
              onSelected: (bool selected) {
                setState(() {
                  selectedFilter = selected ? status : null;
                });
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
