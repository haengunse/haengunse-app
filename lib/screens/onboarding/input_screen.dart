import 'package:flutter/material.dart';
import 'package:haengunse/service/onboarding/input_controller.dart';
import 'package:flutter/gestures.dart';

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
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 45, 24, 24),
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
                  const Text("이름",
                      style: TextStyle(fontWeight: FontWeight.w600)),
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
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[700]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor!),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Radio<String>(
                                value: 'M',
                                groupValue: _gender,
                                onChanged: (val) =>
                                    setState(() => _gender = val!)),
                            const Text("남"),
                            Radio<String>(
                                value: 'F',
                                groupValue: _gender,
                                onChanged: (val) =>
                                    setState(() => _gender = val!)),
                            const Text("여"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("생년월일",
                      style: TextStyle(fontWeight: FontWeight.w600)),
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
                              border: Border.all(color: Colors.grey[700]!),
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
                            border: Border.all(color: Colors.grey[700]!),
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
                      Text("출생시간",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("시간을 입력하면 정확도가 높아집니다.",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: fieldHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[700]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedBirthTime,
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: Colors.white,
                      items: _birthTimeOptions
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedBirthTime = val),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (val) =>
                            setState(() => _agreedToTerms = val!),
                        visualDensity: VisualDensity.compact, // 위아래 여백 줄임
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // 클릭 영역 최소화
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 14),
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
        ));
  }
}
