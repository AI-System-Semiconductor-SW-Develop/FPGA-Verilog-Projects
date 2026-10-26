# 4비트 가산·감산기

[전체 프로젝트 목록](../README.md)

모드 신호 하나로 덧셈과 2의 보수 기반 뺄셈을 선택합니다.

## 동작과 설계

| 모드 | 연산 | 예시 `sum` |
| --- | --- | --- |
| `add_nsub=1` | `a+b` | 5+3 → `1000` |
| `add_nsub=0` | `a+~b+1` | 5-3 → `0010` |
| `add_nsub=0` | 4비트 범위에서 음수 표현 | 3-5 → `1110` |

입력은 `a[3:0]`, `b[3:0]`이며 계산 결과를 `{carry_out, sum}`에 할당합니다. `sum`은 결과의 하위 4비트입니다. 테스트벤치는 15+1, 같은 값의 뺄셈, 음수 결과 등을 포함합니다.

## 실행 구성

- **Design Top:** `adder_subtracter`
- **Design Sources:**
  - [adder_subtracter.v](sources_1/adder_subtracter.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_adder_subtracter.v](sim_1/tb_adder_subtracter.v) | `tb_adder_subtracter` | 덧셈, 뺄셈, 경계값 결과 출력 |

## 보고서와 시연 자료

| 자료 | 파일명 |
| --- | --- |
| [구현 보고서](docs/report.pdf) | `가.감산기 구현_곽혜민.pdf` |

## 현재 상태와 주의사항

`carry_out`은 현재 Verilog 식의 상위 비트입니다. 감산 시 borrow/no-borrow의 의미를 정할 때는 식의 비트 확장 규칙과 실제 파형을 함께 확인해야 합니다. 자동 assertion 대신 `$monitor` 출력으로 결과를 확인하는 테스트입니다.
