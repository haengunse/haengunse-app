import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haengunse/screens/onboarding/progress_loading_page.dart';
import 'package:haengunse/service/manse/manse_api.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _nameController = TextEditingController();
  final ManseApiService _manseApi = ManseApiService();

  DateTime? _selectedDate;
  String _gender = 'M';
  String _calendarType = '양력';
  String? _selectedBirthTime = "모름";
  bool _agreedToTerms = false;

  static const Map<String, String> _birthTimeMap = {
    "자시 (23:30~1:30)": "00:30",
    "축시 (1:30~3:30)": "02:30",
    "인시 (3:30~5:30)": "04:30",
    "묘시 (5:30~7:30)": "06:30",
    "진시 (7:30~9:30)": "08:30",
    "사시 (9:30~11:30)": "10:30",
    "오시 (11:30~13:30)": "12:30",
    "미시 (13:30~15:30)": "14:30",
    "신시 (15:30~17:30)": "16:30",
    "유시 (17:30~19:30)": "18:30",
    "술시 (19:30~21:30)": "20:30",
    "해시 (21:30~23:30)": "22:30",
  };

  final List<String> _birthTimeOptions = [
    "모름",
    ..._birthTimeMap.keys,
  ];

  Future<void> _saveAndGoHome() async {
    if (_nameController.text.isEmpty ||
        _selectedDate == null ||
        !_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("필수 항목을 모두 입력해 주세요.")),
      );
      return;
    }

    final formattedBirthDate =
        "${_selectedDate!.year.toString().padLeft(4, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";

    final isSolar = _calendarType == "양력";
    final birthTimeLabel =
        _selectedBirthTime == null || _selectedBirthTime == "모름"
            ? "모름"
            : _selectedBirthTime!;

    final payload = {
      "birthDate": formattedBirthDate,
      "solar": isSolar,
      "birthTime": birthTimeLabel,
      "gender": _gender,
      "name": _nameController.text,
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProgressLoadingPage(payload: payload),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
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

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.grey[800];
    const fieldHeight = 48.0;

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
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text("내 정보 입력",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold))),
              const SizedBox(height: 1),
              const Center(
                  child: Text("서비스 이용을 위해 간단한 정보를 입력해주세요",
                      style: TextStyle(fontSize: 13, color: Colors.grey))),
              const SizedBox(height: 20),
              Center(
                  child: Image.asset("assets/images/present.png",
                      width: 100, height: 100)),
              const SizedBox(height: 32),
              const Text("이름", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: fieldHeight,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor!)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Radio<String>(
                            value: 'M',
                            groupValue: _gender,
                            onChanged: (val) => setState(() => _gender = val!)),
                        const Text("남"),
                        Radio<String>(
                            value: 'F',
                            groupValue: _gender,
                            onChanged: (val) => setState(() => _gender = val!)),
                        const Text("여"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text("생년월일", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: _pickDate,
                      child: Container(
                        height: fieldHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(_selectedDate != null
                                  ? "${_selectedDate!.year}.${_selectedDate!.month.toString().padLeft(2, '0')}.${_selectedDate!.day.toString().padLeft(2, '0')}"
                                  : "날짜 선택"),
                            ),
                            Icon(Icons.calendar_today,
                                size: 20, color: Colors.grey[800]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: fieldHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]!),
                        borderRadius: BorderRadius.circular(4),
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
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("출생시간", style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("시간을 입력하면 정확도가 높아집니다.",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                height: fieldHeight,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[600]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: _selectedBirthTime,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: Colors.white,
                  items: _birthTimeOptions
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedBirthTime = val),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (val) => setState(() => _agreedToTerms = val!),
                  ),
                  const Expanded(child: Text("이용약관 동의(필수)")),
                  TextButton(onPressed: () {}, child: const Text("보기")),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _saveAndGoHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF82c784),
                    elevation: 4,
                    shadowColor: const Color.fromARGB(255, 173, 173, 173),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text("저장",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
