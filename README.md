# gds_flutter

Flutter 기반 Grimity Design System 모노레포입니다.

## Packages

| Package | 역할 | 비고 |
|---|---|---|
| `gds_tokens` | Atomic/Semantic 토큰 정의 | 수동 관리 |
| `gds_foundation` | 아이콘/이미지/로띠/타이포 등 공통 기반 | 토큰 의존 |
| `gds_components` | 실제 UI 컴포넌트 | foundation + tokens 의존 |
| `gds_widgetbook` | 컴포넌트 문서/프리뷰 | widgetbook 기반 |

## Project Structure

```text
/gds
├── lib/
│   └── gds.dart                          # Root export
├── packages/
│   ├── tokens/                           # [Package] tokens
│   │   ├── lib/
│   │   │   ├── gds_tokens.dart           # Main export
│   │   │   └── src/
│   │   │       ├── atomic/               # Primitive tokens
│   │   │       │   ├── atomic.dart
│   │   │       │   ├── gds_atomic_color.dart
│   │   │       │   ├── gds_atomic_spacing.dart
│   │   │       │   └── ...
│   │   │       └── semantic/             # Semantic tokens
│   │   │           ├── semantic.dart
│   │   │           ├── gds_semantic_color.dart
│   │   │           ├── gds_semantic_typography.dart
│   │   │           └── ...
│   │   └── pubspec.yaml
│   ├── foundation/                       # [Package] foundation
│   │   ├── lib/
│   │   │   ├── gds_foundation.dart       # Main export
│   │   │   └── src/
│   │   │       ├── gds_colors.dart
│   │   │       ├── gds_typography.dart
│   │   │       ├── gds_icon.dart
│   │   │       ├── gds_lottie.dart
│   │   │       ├── gds_image.dart
│   │   │       └── ...
│   │   ├── assets/
│   │   │   ├── fonts/
│   │   │   ├── images/
│   │   │   ├── vector/
│   │   │   └── lottie/
│   │   └── pubspec.yaml
│   ├── components/                       # [Package] components
│   │   ├── lib/
│   │   │   ├── gds_components.dart       # Main export
│   │   │   └── src/
│   │   │       ├── button/
│   │   │       ├── input/
│   │   │       ├── control/
│   │   │       ├── micro_interaction/
│   │   │       └── ...
│   │   └── pubspec.yaml
│   └── widgetbook/                       # [Package] widgetbook
│       ├── lib/main.dart
│       ├── build.yaml
│       └── pubspec.yaml
├── pubspec.yaml                          # Workspace + melos config
```

## Quick Start

```bash
# 1) Flutter version
fvm install && fvm use --force

# 2) Install dependencies (workspace)
dart run melos run install

# 3) Generate widgetbook files
dart run melos run build-widgetbook

# 4) Run widgetbook
cd packages/widgetbook && fvm flutter run -d chrome
```

## Import Rules

```dart
import 'package:gds_tokens/gds_tokens.dart';
```

`src/...` 직접 import는 지양합니다.
