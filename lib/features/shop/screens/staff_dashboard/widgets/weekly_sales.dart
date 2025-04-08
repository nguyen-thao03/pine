import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pine_admin_panel/common/widgets/icons/p_circular_icon.dart';
import 'package:pine_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:pine_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class PWeeklySalesGraph extends StatelessWidget {
  const PWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return PRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: PSizes.md,
              ),
              const SizedBox(width: PSizes.spaceBtwItems),
              Text('Doanh thu tuần', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwSections),

          // Graph
          Obx(
                () {
              if (controller.weeklySales.isEmpty) {
                return const SizedBox(
                  height: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [PLoaderAnimation()],
                  ),
                );
              }

              final List<double> salesData = controller.weeklySales.take(7).toList();
              return SizedBox(
                height: 400,
                child: BarChart(
                  BarChartData(
                    titlesData: buildFlTitlesData(salesData),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(top: BorderSide.none, right: BorderSide.none),
                    ),
                    gridData: const FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50000,
                    ),
                    barGroups: salesData.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            width: 25,
                            toY: entry.value,
                            color: PColors.primary,
                            borderRadius: BorderRadius.circular(PSizes.sm),
                          ),
                        ],
                      );
                    }).toList(),
                    groupsSpace: 30,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => PColors.secondary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData(List<double> weeklySales) {
  const List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  double maxOrder = weeklySales.isNotEmpty ? weeklySales.reduce((a, b) => a > b ? a : b) : 1;
  double stepHeight = (maxOrder / 5).ceilToDouble();

  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          int index = value.toInt();
          if (index >= 0 && index < days.length) {
            return SideTitleWidget(
              axisSide: AxisSide.bottom,
              space: 5,
              child: Text(days[index], style: TextStyle(fontSize: 12)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: stepHeight <= 0 ? 50000 : stepHeight,
        reservedSize: 50,
      ),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}