import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('개인정보 수집')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            '''
행운세(회사)는 아래와 같이 개인정보를 수집·이용합니다. 동의를 거부할 권리가 있으며, 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.

수집 항목
 •    이름, 생년월일(양력/음력 포함), 성별, 위치정보(선택 시),
수집 방법
 •    앱 실행 시 사용자가 직접 입력하는 방식
 •    기기 위치정보 접근 권한을 허용한 경우 자동 수집,
이용 목적
 •    운세 정보 및 위치 기반 날씨 정보 제공
 •    인공지능 기반 해석(GPT) 결과 생성
 •    서비스 품질 개선을 위한 오류 분석,
보유 기간
 •    사용자가 앱을 삭제하거나 정보 수정을 요청한 경우 즉시 파기,

이름, 생년월일, 위치정보를 입력받아 운세 및 날씨 정보를 제공하며, GPT 분석을 위해 OpenAI에 일시적으로 전송될 수 있습니다.
자세한 내용은 개인정보처리방침을 확인해주세요.
            ''',
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
