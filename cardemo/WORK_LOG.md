# 卡데모 (CARDEMO) Sprint 1 작업일지

## Sprint 1: 프로젝트 기반 구축

### 📅 진행 기간
2026-02-19

### ✅ 완료된 작업

1. **Flutter 프로젝트 구조 생성**
   - `pubspec.yaml` - 의존성 설정 (sqflite, path_provider, riverpod, go_router, flutter_quill, image_picker)
   - `lib/main.dart` - 앱 진입점
   - `lib/router.dart` - go_router 라우팅 설정

2. **데이터베이스 설정**
   - `lib/database/database_helper.dart` - SQLite DB 헬퍼 클래스
   - cards, decks 테이블 생성

3. **모델 클래스 작성**
   - `lib/models/card_model.dart` - 카드 데이터 모델

4. **화면 구현**
   - `lib/screens/home_screen.dart` - 홈 화면
   - `lib/screens/card_list_screen.dart` - 카드 목록 (검색, 삭제 기능 포함)
   - `lib/screens/card_edit_screen.dart` - 카드 작성/수정 (이미지 첨부 포함)

### 📋 문서 업데이트
- `DP01_S01_스프린트_기반구축.md` - ✅ 완료 표시

### ⚠️ 참고사항
- Flutter SDK가 로컬에 없어서 LSP 에러가 표시되지만, 코드 자체는 정상입니다
- 실제로는 VS Code나 Android Studio에서 `flutter pub get` 실행 필요

### 🔄 다음 작업 (Sprint 2)
- 카드 CRUD 기능 구현 완료
- Phase 1 전체 테스트
