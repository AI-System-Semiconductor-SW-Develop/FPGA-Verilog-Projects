# 초기 디바운싱 실습 기록

[전체 프로젝트 목록](../README.md)

이전 샘플링 방식의 테스트벤치를 보관한 폴더입니다.

## 동작과 설계

테스트벤치는 버튼 노이즈와 안정된 누름을 생성하고 LED를 검사하도록 작성되어 있습니다. 주석에는 실제 분주비 1,250,000을 시뮬레이션용 100으로 줄이는 방식이 설명되어 있습니다.

현재 상태를 실행 가능한 예제로 오해하지 않도록 초기 실습 기록으로 분류합니다. tick 기반 구현은 [my_btn_debounce](../my_btn_debounce/README.md), LED FSM 연결 예제는 [06_1.btn_debounce_10ms](../06_1.btn_debounce_10ms/README.md)를 참고하세요.

## 실행 구성

- **Design Top:** `현재 단독 실행 가능한 Top 없음`
- **Design Sources:**
  - [tick_generator.v](sources_1/tick_generator.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_btn_debounce.v](sim_1/tb_btn_debounce.v) | `tb_btn_debounce` | 필요한 설계 누락으로 현재 단독 실행 불가 |

문서 작성 과정에서 시뮬레이션을 새로 실행하지 않았습니다. PASS/FAIL 문구는 테스트벤치가 기대하는 결과이며 실제 재실행 결과와 구분합니다.

## 현재 상태와 주의사항

`tick_generator.v`는 빈 파일입니다. 테스트벤치가 요구하는 `top_btn_debounce`가 이 폴더에 없고 `defparam` 경로도 인스턴스 이름과 다릅니다. 다른 폴더의 현재 Top은 내부 구조와 LED 폭이 달라 단순히 함께 추가하는 것으로 해결되지 않습니다.
