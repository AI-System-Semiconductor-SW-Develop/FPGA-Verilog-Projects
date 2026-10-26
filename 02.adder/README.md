# 반가산기와 전가산기

[전체 프로젝트 목록](../README.md)

반가산기를 재사용하여 carry-in을 처리하는 전가산기를 구성합니다.

## 동작과 설계

반가산기는 `sum = a ^ b`, `carry_out = a & b`를 계산합니다. 전가산기는 첫 번째 반가산기로 `a+b`를 계산하고, 두 번째 반가산기로 중간 합과 `carry_in`을 더합니다. 두 carry를 OR하여 최종 carry-out을 만듭니다.

```text
a, b → half_adder → 중간 합 + carry_in → half_adder → sum
          carry ───────────── OR ───────── carry → carry_out
```

전가산기의 기대 결과는 `{carry_out, sum} = a + b + carry_in`입니다. 이 모듈은 [7비트 가산기](../04_adder7/README.md)의 기본 블록으로 재사용됩니다.

## 실행 구성

- **Design Top:** `half_adder 또는 full_adder`
- **Design Sources:**
  - [half_adder.v](sources_1/half_adder.v)
  - [full_adder.v](sources_1/full_adder.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_half_adder.v](sim_1/tb_half_adder.v) | `tb_half_adder` | 반가산기 입력 조합과 파형 확인 |

## 현재 상태와 주의사항

현재 테스트벤치는 반가산기만 검사하며 자동 PASS/FAIL 판정은 없습니다. 전가산기에는 별도 단위 테스트가 없습니다.
