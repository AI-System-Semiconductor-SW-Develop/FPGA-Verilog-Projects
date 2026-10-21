# 게이트 수준 전가산기

[전체 프로젝트 목록](../README.md)

같은 전가산기를 게이트 프리미티브와 산술 연산자로 각각 표현합니다.

## 동작과 설계

`gate_netlist`는 `xor`, `and`, `or` 프리미티브를 연결합니다. `full_adder_1bit`는 입력을 2비트로 확장한 뒤 산술 연산으로 `{cout,sum}`을 계산합니다. 두 모듈의 입력은 `a`, `b`, `cin`, 출력은 `sum`, `cout`입니다.

```text
s1 = a XOR b
sum = s1 XOR cin
cout = (a AND b) OR (s1 AND cin)
```

구조적 기술과 데이터 흐름 기술을 비교할 수 있습니다. 검증 시 입력 8개 조합을 모두 주고 두 모듈의 출력을 비교하는 방식이 적합합니다.

## 실행 구성

- **Design Top:** `gate_netlist 또는 full_adder_1bit`
- **Design Sources:**
  - [gate_netlist.v](sources_1/gate_netlist.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

전용 테스트벤치가 포함되어 있지 않습니다.

문서 작성 과정에서 시뮬레이션을 새로 실행하지 않았습니다. PASS/FAIL 문구는 테스트벤치가 기대하는 결과이며 실제 재실행 결과와 구분합니다.

## 현재 상태와 주의사항

현재 폴더에는 전용 테스트벤치와 보드 XDC가 없습니다. 위 비교는 권장 검증 방법이며 수행된 테스트 결과를 뜻하지 않습니다.
