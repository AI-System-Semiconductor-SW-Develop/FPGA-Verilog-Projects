# 1비트 2:1 멀티플렉서

[전체 프로젝트 목록](../README.md)

선택 신호에 따라 두 입력 중 하나를 출력합니다.

## 동작과 설계

| `sel` | `out` |
| --- | --- |
| 0 | `b` |
| 1 | `a` |
| 미정 값 | `1'bx` |

`always @(sel,a,b)`와 `case`로 구현한 조합회로입니다. 내부 `r_out` 값을 연속 할당으로 출력 포트에 연결합니다.

## 실행 구성

- **Design Top:** `mux2_1`
- **Design Sources:**
  - [mux.v](sources_1/mux.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_mux2_1.v](sim_1/tb_mux2_1.v) | `tb_mux2_1` | 입력과 선택 신호 변화에 따른 출력 확인 |

문서 작성 과정에서 시뮬레이션을 새로 실행하지 않았습니다. PASS/FAIL 문구는 테스트벤치가 기대하는 결과이며 실제 재실행 결과와 구분합니다.

## 현재 상태와 주의사항

폴더 이름에는 decoder/encoder/compare가 있지만 현재 포함된 회로는 MUX뿐입니다. 디코더와 인코더는 [05.decoder](../05.decoder/README.md)에 있습니다.
