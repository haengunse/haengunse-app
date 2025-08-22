import 'package:flutter/material.dart';
import 'package:haengunse/screens/onboarding/input_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/home/lucky_section.dart';
import 'package:haengunse/screens/home/card_section.dart';
import 'package:haengunse/screens/home/day_section.dart';
import 'package:haengunse/service/card/saju_cache_storage.dart';
import 'package:haengunse/service/day/day_cache_storage.dart';
import 'package:haengunse/service/dream/dream_chat_storage.dart';
import 'package:haengunse/service/today/today_cache_storage.dart';
import 'package:haengunse/utils/city_mapper.dart';

// overscroll 방지용 커스텀 ScrollBehavior
class NoOverScrollBehavior extends ScrollBehavior {
  const NoOverScrollBehavior();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '정보를 삭제하시겠습니까?\n삭제된 정보는 복구할 수 없습니다.',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dialogButton(
                  label: '확인',
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  isPrimary: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dialogButton({
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black26,
          width: 0.5,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "행운세";

  @override
  void initState() {
    super.initState();
    _initCityMap();
    _loadUserData();
  }

  Future<void> _initCityMap() async {
    await CityMapper.loadCityMap();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name') ?? "행운세";
    final gender = prefs.getString('gender') ?? "모름";
    final manseInfo = prefs.getString('manseInfo') ?? "없음";

    debugPrint("이름: $name");
    debugPrint("성별: $gender");
    debugPrint("만세력: $manseInfo");

    setState(() {
      userName = name;
    });
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    await SajuCacheStorage.clearResponse();
    await DayCacheStorage.clearAll();
    await DreamChatStorage.clearChat();
    await TodayCacheStorage.clearResponse();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const InputScreen()),
      (route) => false,
    );
  }

  void _showLicense() {
    showLicensePage(
      context: context,
      applicationName: '행운세',
      applicationVersion: '1.0.0',
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: onTap,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFDDDDDD),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 244, 231),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              width: double.infinity,
              alignment: Alignment.center,
              color: const Color.fromARGB(255, 231, 244, 231),
              child: const Text(
                'MENU',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _drawerTile(
              icon: Icons.edit,
              title: '내 정보 수정',
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InputScreen(showBackButton: true),
                    ),
                  );
                });
              },
            ),
            _drawerTile(
              icon: Icons.delete,
              title: '정보 삭제',
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        ConfirmDeleteDialog(onConfirm: _clearUserData),
                  );
                });
              },
            ),
            _drawerTile(
              icon: Icons.info_outline,
              title: '오픈소스 라이선스',
              onTap: _showLicense,
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: ScrollConfiguration(
        behavior: const NoOverScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionLucky(userName: userName),
              const SectionCard(),
              const SectionDay(),
            ],
          ),
        ),
      ),
    );
  }
}
