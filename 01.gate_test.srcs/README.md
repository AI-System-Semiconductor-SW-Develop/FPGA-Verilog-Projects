# 기본 논리 게이트

[전체 프로젝트 목록](../README.md)

두 스위치 입력으로 여섯 가지 논리 연산을 구현합니다.

## 동작과 설계

| LED | 연산 |
| --- | --- |
| `led[0]` | `sw[0] & sw[1]` (AND) |
| `led[1]` | `sw[0] \| sw[1]` (OR) |
| `led[2]` | `~(sw[0] & sw[1])` (NAND) |
| `led[3]` | `~(sw[0] \| sw[1])` (NOR) |
| `led[4]` | `sw[0] ^ sw[1]` (XOR) |
| `led[5]` | `~sw[0]` (NOT) |

클럭 없이 입력 변화가 출력에 반영되는 조합회로입니다. Basys 3의 SW0(V17), SW1(V16)을 사용하고 LED0~5에 결과를 표시합니다. 네 가지 입력 조합을 진리표와 비교할 수 있습니다.

## 실행 구성

- **Design Top:** `gates`
- **Design Sources:**
  - [gates.v](sources_1/gates.v)
- **보드 제약:** [Basys 3 XDC](constrs_1/Basys3-Master_orginal.xdc)

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_gates.v](sim_1/tb_gates.v) | `tb_gates` | 현재 DUT 포트와 불일치하여 수정 필요 |

## 현재 상태와 주의사항

`tb_gates`는 `.a(i_a)`를 연결하지만 현재 설계의 포트는 `sw[1:0]`입니다. 테스트벤치 연결을 `.sw(i_a[1:0])`로 수정해야 실행할 수 있습니다. 테스트 종료에는 `$stop`을 사용합니다.
