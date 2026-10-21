# 디코더와 인코더

[전체 프로젝트 목록](../README.md)

입력의 코드 변환과 우선순위 처리를 구현합니다.

## 동작과 설계

`decoder`는 `00/01/10/11`을 각각 `0001/0010/0100/1000`으로 변환합니다. `encoder`는 반대 방향의 변환을 연습하는 회로입니다.

`priority_encoder`는 여러 입력이 동시에 1이어도 가장 높은 비트를 선택합니다.

| 입력 `a` | 출력 `led` | `v` |
| --- | --- | --- |
| `1xxx` | `11` | 1 |
| `01xx` | `10` | 1 |
| `001x` | `01` | 1 |
| `0001` | `00` | 1 |
| `0000` | `00` | 0 |

위 표의 `x`는 하위 비트가 결과에 영향을 주지 않는다는 뜻입니다. 세 회로는 각각 별도 Top으로 실행합니다.

## 실행 구성

- **Design Top:** `decoder / encoder / priority_encoder 중 선택`
- **Design Sources:**
  - [decoder.v](sources_1/decoder.v)
  - [encoder.v](sources_1/encoder.v)
  - [priority_encoder.v](sources_1/priority_encoder.v)
- **보드 제약:** XDC 미포함. 보드 실행에는 Top 포트에 맞는 핀 제약이 필요합니다.

Vivado 프로젝트 생성과 합성·보드 실행 절차는 [공통 실행 방법](../README.md#실행-방법)을 따릅니다. 위 소스만 Design Sources에 추가하고 테스트벤치는 Simulation Sources에 분리합니다.

## 시뮬레이션

| 테스트벤치 | Simulation Top | 확인 범위 / 상태 |
| --- | --- | --- |
| [tb_decoder.v](sim_1/tb_decoder.v) | `tb_decoder` | 2비트 입력 → one-hot 출력 |
| [tb_encoder.v](sim_1/tb_encoder.v) | `tb_encoder` | 인코더 입력별 출력, 아래 구현 문제 참고 |
| [tb_priority.v](sim_1/tb_priority.v) | `tb_priority` | 16가지 입력 조합의 우선순위와 유효 신호 |

문서 작성 과정에서 시뮬레이션을 새로 실행하지 않았습니다. PASS/FAIL 문구는 테스트벤치가 기대하는 결과이며 실제 재실행 결과와 구분합니다.

## 보고서와 시연 자료

제공받은 보고서의 사본입니다. 보고서가 현재 RTL과 동일한 버전인지까지 대조 검증한 것은 아닙니다.

| 자료 | 제공 원본명 |
| --- | --- |
| [우선순위 인코더 보고서](docs/priority-encoder-report.pdf) | `priority_encoder_곽헤민.pdf` |

## 현재 상태와 주의사항

`encoder.v`에는 `a[1] == 4'b0010` 비교가 있어 `0010`을 올바르게 처리하지 못합니다. 또한 기본 대입이 없어 일부 입력에서 이전 출력이 유지될 수 있습니다. 일반 인코더는 수정이 필요한 상태이며 우선순위 인코더와 구분합니다.
