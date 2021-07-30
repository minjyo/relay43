# 쭘(Zzoom)
![https://user-images.githubusercontent.com/71375034/126758427-0b6c1f17-b74c-4747-b81c-00d27c472794.png](https://user-images.githubusercontent.com/71375034/126758427-0b6c1f17-b74c-4747-b81c-00d27c472794.png)
## 주제

- STT(speech to text) 기능을 지원하는 실시간 화상, 음성 채팅 서비스

## 프로젝트 참여자
### 기획
- 권재호, 김영한, 최완식, 오석호, 장다윗, 이효동, 임종현, 김채범
### 개발 A
- 김동환, 김재훈, 김필선, 유정한, 유주현, 박태현, 오창민

## 기획 의도

- 온라인 학습자들은 상호 소통을 위해 zoom 같은 실시간 음성 채팅 프로그램을 사용하지만, 사용자가 여러명일 경우, 혹은 불안정한 네트워크로 인한 끊김 등으로 소통에 불편이 생기는 경우가 발생.
- 실시간 음성 채팅은 휘발성이 강해 한번 놓치면 내용을 이해하기가 어려움.
- 따라서 기본적으로는 실시간 음성 채팅으로 하되, 음성 채팅 내용을 실시간으로 변환하여 텍스트로(speech-to-text) 제공하면 음성 방식과 텍스트 방식의 장점을 모두 취합한 라이브 채팅 프로그램을 만들 수 있을 것.
- 웹 기반 베이스로 제작

## 주요 기능

- 실시간 텍스트 채팅 서비스
- zoom과 유사한 실시간 음성 채팅 서비스 (가능하면 비디오까지)
- 음성 채팅 내용을 이해하기 쉽게 speech-to-text 기능을 이용해 텍스트 채팅으로 전송

## 세부 기능

### A. 실시간 텍스트 채팅 서비스

- 실시간 텍스트 채팅 : 현재시간 / 발신자 닉네임 / 내용 / 키보드(텍스트) 표시 : 음성을 텍스트로 변환한 내용과 구분할 수 있도록 / 이모티콘 발신 기능
- 참가자가 전부 퇴장할 시 서비스가 자동 종료된다.

### B. 실시간 음성(+화상) 채팅 서비스

- 말하고 있는 사람 하이라이트
- 설정 구현 : 마이크 / 스피커 설정 / STT 여부

### C. 음성 채팅 내용을 텍스트로 변환하여 채팅으로 전송

- 말이 끝나면(즉, 하이라이트가 없어지면) 채팅에 음성 내용을 텍스트로 변환하여 전송
- STT 설정
    - 현재시간 / 발신자 닉네임 / 내용 / 마이크(음성 변환) 표시  / 이모티콘 추가

### 추가사항

- 전체적인 틀
    - 각 html 페이지 연결 및 제작
    - 서버에서는 회의실 여러 개를 동시에 진행할 수 있도록 방 코드를 방 개설할 때 출력해야 함
    - 설정 구현 :  채팅창 위치 설정, 다크모드
    - UX /UI는 플로우차트와 와이어프레임을 바탕으로 제작
    - 나가기, 음소거, 이모티콘 버튼 등 구현

### ※ 선택사항

방장 기능을 구현한다면 STT기능을 방을 만들 때, 혹은 방장만 선택할 수 있는 식으로 구현할 수 있음

## 플로우 차트

![https://user-images.githubusercontent.com/71375034/126757360-c8de7fec-fd4f-490d-b65e-1b864926d08b.png](https://user-images.githubusercontent.com/71375034/126757360-c8de7fec-fd4f-490d-b65e-1b864926d08b.png)

![https://user-images.githubusercontent.com/71375034/126757410-b19c94f0-7317-4194-ad9a-4fbb256a6d46.png](https://user-images.githubusercontent.com/71375034/126757410-b19c94f0-7317-4194-ad9a-4fbb256a6d46.png)


## 실행 예시
![https://user-images.githubusercontent.com/76931330/126756685-72aae473-2997-45cd-b56e-9dc71a2e99bb.png](https://user-images.githubusercontent.com/76931330/126756685-72aae473-2997-45cd-b56e-9dc71a2e99bb.png)

![https://user-images.githubusercontent.com/37871541/126757066-518fb406-f593-46e4-b36f-07961527b0e6.gif](https://user-images.githubusercontent.com/37871541/126757066-518fb406-f593-46e4-b36f-07961527b0e6.gif)

![https://user-images.githubusercontent.com/71375034/126757489-85cc91bc-9de2-4b35-bbcf-97fb081a542b.png](https://user-images.githubusercontent.com/71375034/126757489-85cc91bc-9de2-4b35-bbcf-97fb081a542b.png)

## 참고 사항

- agora real-time message

    [https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=Android#internet-of-things-iot](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=Android#internet-of-things-iot)

- agora API

    [https://sso.agora.io/en/signin](https://www.agora.io/en/)

- google_speech api(for STT)

    [https://pub.dev/packages/google_speech](https://pub.dev/packages/google_speech)

- google_speech streaming SST guide

    [https://cloud.google.com/speech-to-text/docs/streaming-recognize](https://cloud.google.com/speech-to-text/docs/streaming-recognize)

- using gcloud api with flutter, dart

    [https://stackoverflow.com/questions/55493003/using-gcloud-speech-api-for-real-time-speech-recognition-in-dart-flutter](https://stackoverflow.com/questions/55493003/using-gcloud-speech-api-for-real-time-speech-recognition-in-dart-flutter)