import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  final Map<String, dynamic>? requestData;
  final Map<String, dynamic>? responseData;

  const TodayScreen({
    super.key,
    this.requestData,
    this.responseData,
  });

  Widget _buildDataRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? "-", overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final req = requestData ?? {};
    final res = responseData ?? {};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("오늘의 운세"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("📥 요청 정보", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              _buildDataRow("이름", req['name']),
              _buildDataRow("성별", req['gender']),
              _buildDataRow("생년월일", req['birthDate']),
              _buildDataRow("출생시간", req['birthTime']),
              _buildDataRow("달력", req['solar']),
              const SizedBox(height: 30),
              const Divider(),
              const Text("📤 응답 정보", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              if (res.isEmpty)
                const Text("응답 데이터 없음", style: TextStyle(color: Colors.grey))
              else
                ...res.entries.map(
                  (entry) => _buildDataRow(entry.key, entry.value.toString()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
