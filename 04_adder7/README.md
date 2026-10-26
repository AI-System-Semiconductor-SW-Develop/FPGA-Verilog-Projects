# 7비트 리플 캐리 가산기

[전체 프로젝트 목록](../README.md)

1비트 전가산기 7개를 직렬 연결해 7비트 덧셈을 구현합니다.

## 동작과 설계

입력은 `a[6:0]`, `b[6:0]`, `carry_in`이고 출력은 `sum[6:0]`, `carry_out`입니다. 하위 비트의 carry가 다음 비트로 전달됩니다.

| 입력 예 | 기대 결과 `{carry_out, sum}` |
| --- | --- |
| 15 + 10 | 25 |
| 63 + 1 | 64 |
| 127 + 1 | 128 (`carry_out=1`, `sum=0`) |
| 100 + 50 + 1 | 151 |

테스트벤치에는 위 경계값 입력이 포함되어 있습니다. 리플 캐리 구조와 계층적 모듈 재사용을 살펴보는 예제입니다.

## 실행 구성

- **Design Top:** `adder7`
- **Design Sources:**
  - [adder7.v](sources_1/adder7.v)
  - [full_adder.v](../02.adder/sources_1/full_adder.v)
  - [half_adder.v](../02.adder/sources_1/half_adder.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_adder7.v](sim_1/tb_adder7.v) | `tb_adder7` | 합과 carry 전파 파형 확인 |

## 현재 상태와 주의사항

이 폴더의 소스만 추가하면 `full_adder`가 없어 elaboration이 실패합니다. 위 목록의 외부 의존 파일 두 개를 함께 추가합니다. 테스트벤치는 파형 확인용입니다.
