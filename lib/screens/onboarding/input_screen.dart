import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haengunse/service/onboarding/input_controller.dart';

class InputScreen extends StatefulWidget {
  final bool showBackButton;
  const InputScreen({super.key, this.showBackButton = false});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _nameController = TextEditingController();

  DateTime? _selectedDate;
  String _gender = 'M';
  String _calendarType = '양력';
  String? _selectedBirthTime = "모름";
  bool _agreedToTerms = false;

  static const Map<String, String> _birthTimeMap = {
    "자시 (23:30~1:30)": "00:30",
    "축시 (1:31~3:30)": "02:30",
    "인시 (3:31~5:30)": "04:30",
    "묘시 (5:31~7:30)": "06:30",
    "진시 (7:31~9:30)": "08:30",
    "사시 (9:31~11:30)": "10:30",
    "오시 (11:31~13:30)": "12:30",
    "미시 (13:31~15:30)": "14:30",
    "신시 (15:31~17:30)": "16:30",
    "유시 (17:31~19:30)": "18:30",
    "술시 (19:31~21:30)": "20:30",
    "해시 (21:31~23:30)": "22:30",
  };

  final List<String> _birthTimeOptions = [
    "모름",
    ..._birthTimeMap.keys,
  ];

  Future<void> _saveAndGoHome() async {
    await InputController.saveAndNavigateHome(
      context: context,
      name: _nameController.text,
      selectedDate: _selectedDate,
      calendarType: _calendarType,
      gender: _gender,
      selectedBirthTime: _selectedBirthTime,
      agreedToTerms: _agreedToTerms,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.grey[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.grey[800]!,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[800]),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  TextSpan _linkSpan(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        fontSize: 14.sp,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.grey[800];
    final fieldHeight = 48.h;

    return Theme(
      data: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.grey[800]!,
          onPrimary: Colors.white,
          secondary: Colors.grey[800]!,
          onSecondary: Colors.white,
          surface: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected))
              return Colors.grey[800];
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.grey[800]),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text("내 정보 입력",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold))),
                SizedBox(height: 1.h),
                Center(
                    child: Text("서비스 이용을 위해 간단한 정보를 입력해주세요",
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey))),
                SizedBox(height: 20.h),
                Center(
                    child: Image.asset("assets/images/present.png",
                        width: 100.w, height: 100.h)),
                SizedBox(height: 32.h),
                Text("이름",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: fieldHeight,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 12.w),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Radio<String>(
                              value: 'M',
                              groupValue: _gender,
                              onChanged: (val) =>
                                  setState(() => _gender = val!)),
                          Text("남", style: TextStyle(fontSize: 14.sp)),
                          Radio<String>(
                              value: 'F',
                              groupValue: _gender,
                              onChanged: (val) =>
                                  setState(() => _gender = val!)),
                          Text("여", style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text("생년월일",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp)),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: _pickDate,
                        child: Container(
                          height: fieldHeight,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700]!),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate != null
                                      ? "${_selectedDate!.year}.${_selectedDate!.month.toString().padLeft(2, '0')}.${_selectedDate!.day.toString().padLeft(2, '0')}"
                                      : "날짜 선택",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                              Icon(Icons.calendar_today,
                                  size: 20.sp, color: Colors.grey[800]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: fieldHeight,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700]!),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: DropdownButton<String>(
                          value: _calendarType,
                          isExpanded: true,
                          underline: const SizedBox(),
                          iconEnabledColor: primaryColor,
                          dropdownColor: Colors.white,
                          items: ["양력", "음력"]
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _calendarType = val!),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("출생시간",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("시간을 입력하면 정확도가 높아집니다.",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  height: fieldHeight,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[700]!),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedBirthTime,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    items: _birthTimeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedBirthTime = val),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (val) => setState(() => _agreedToTerms = val!),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.black87, fontSize: 14.sp),
                            children: [
                              const TextSpan(text: "(필수) "),
                              _linkSpan("이용약관", () {
                                Navigator.pushNamed(context, '/terms');
                              }),
                              const TextSpan(text: " 및 "),
                              _linkSpan("개인정보 수집", () {
                                Navigator.pushNamed(context, '/privacy');
                              }),
                              const TextSpan(text: "에 동의합니다."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _saveAndGoHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF82c784),
                      elevation: 4,
                      shadowColor: const Color.fromARGB(255, 173, 173, 173),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r)),
                    ),
                    child: Text("저장",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
