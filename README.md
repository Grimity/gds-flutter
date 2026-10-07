<img src="https://github.com/Grimity/gds-flutter/raw/refs/heads/main/.github/assets/banner.svg">

## 소개

Grimity Flutter Design System — 토큰, 테마, 아이콘, 재사용 컴포넌트와 analyzer 규칙 등을 제공하는 Flutter 워크스페이스입니다.

## 초기 설정

프로젝트 내의 *pubspec.yaml*에 다음과 같이 의존성을 추가해주세요.

```yaml
dependencies:
  gds_flutter:
    git:
      url: https://github.com/Grimity/gds-flutter.git
      path: packages/gds_flutter
```

린트의 경우, 프로젝트 내의 *analysis_options.yaml*에 다음과 같이 의존성을 추가해주세요.

```yaml
plugins:
  gds_lints:
    git:
      url: https://github.com/Grimity/gds-flutter.git
      path: packages/gds_lints
```

## 프리뷰 기능

해당 프로젝트는 IDE 내에서 쉽게 위젯을 개발하고 디버깅하기 위해 VSCode용 [vscode-flutter-design-preview](https://github.com/MTtankkeo/vscode-flutter-design-preview)를 사용합니다.
