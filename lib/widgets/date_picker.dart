import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/pembimbing_controller.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/themes.dart';

class DatePickerController extends GetxController {
  final PembimbingController pembimbingController =
      Get.put(PembimbingController());

  var selectedDateIndex = 0.obs;
  var dates = List<String>.generate(31, (index) => 'Hari ${index + 1}').obs;

  @override
  void onInit() {
    super.onInit();
    _setTodayAsDefault();
  }

  void _setTodayAsDefault() {
    final today = DateTime.now();
    selectedDateIndex.value = today.day; // Set index berdasarkan hari ini
  }

  void setDate(int index) {
    print('Date selected: $index'); // Debugging log
    selectedDateIndex.value = index;
  }

  Future<void> getMahasiswaByLokasi(String date, int id) async {
    Log.debug('Fetching data for date: $date and id: $id'); // Debugging log
    // Logika untuk mengambil data berdasarkan lokasi dan tanggal.
    pembimbingController.getDetailLokasiPpl(id, date);
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, required this.scrollController, required this.id})
      : super(key: key);

  final ScrollController scrollController;
  final int id;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DatePickerController dateController = Get.put(DatePickerController());

  @override
  void initState() {
    super.initState();
    // Menunggu frame pertama untuk memanggil scroll otomatis setelah inisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(dateController.selectedDateIndex.value);
    });
  }

  // Fungsi untuk scroll ke indeks tertentu
  void _scrollTo(double offset) {
    if (offset <= widget.scrollController.position.maxScrollExtent &&
        offset >= widget.scrollController.position.minScrollExtent) {
      widget.scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fungsi untuk scroll berdasarkan index
  void _scrollToIndex(int index) {
    if (widget.scrollController.hasClients) {
      final itemWidth = 51.r;
      final viewportWidth = widget.scrollController.position.viewportDimension;
      final scrollOffset = widget.scrollController.position.minScrollExtent +
          index * itemWidth -
          (viewportWidth - itemWidth) / 2;

      widget.scrollController.animateTo(
        scrollOffset.clamp(
          widget.scrollController.position.minScrollExtent,
          widget.scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Container(
            height: 45.h,
            width: 270.w,
            margin: EdgeInsets.symmetric(horizontal: 21.w),
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is OverscrollIndicatorNotification) {
                  notification.disallowIndicator();
                }
                return false;
              },
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      dateController.setDate(index); // Update state
                      await Future.delayed(
                          const Duration(milliseconds: 200)); // Optional delay
                      await dateController.getMahasiswaByLokasi(
                        '2025-01-${index + 1}',
                        widget.id,
                      );
                    },
                    child: Container(
                      height: 45.r,
                      width: 45.r,
                      decoration: BoxDecoration(
                        color: index == dateController.selectedDateIndex.value
                            ? kSecondColor
                            : null,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateController.dates[index].substring(0, 3),
                            style: blackTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: index ==
                                      dateController.selectedDateIndex.value
                                  ? kWhiteColor
                                  : kBlackColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${index + 1}',
                            style: blackTextStyle.copyWith(
                              fontSize: 16.sp,
                              color: index ==
                                      dateController.selectedDateIndex.value
                                  ? kWhiteColor
                                  : kBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) => SizedBox(width: 6.w),
                itemCount: dateController.dates.length,
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () {
            final currentPosition = widget.scrollController.position.pixels;
            final viewportWidth =
                widget.scrollController.position.viewportDimension;
            final width = 52.r;
            final scrollOffset = currentPosition + viewportWidth - width;

            _scrollTo(scrollOffset);
          },
          child: Container(
            height: 45.r,
            width: 45.r,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/next_date.svg',
                  width: 40.r,
                  height: 20.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
