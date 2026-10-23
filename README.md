# FPGA Verilog Projects

Verilog HDL로 조합논리부터 버튼 입력 처리, FSM, 시프트 레지스터, 카운터까지 구현한 FPGA 실습 모음입니다. Basys 3용 RTL·핀 제약·테스트벤치와 제공받은 구현 보고서 및 보드 시연 영상을 함께 정리했습니다.

각 실습의 **설계 구조, Top 설정, 소스 의존성, 테스트 상태, 보고서와 영상**은 아래 상세 README에서 확인할 수 있습니다.

## 주요 프로젝트

| 프로젝트 | 설계 포인트 | 자료 |
| --- | --- | --- |
| [분·초 시계 & 스톱워치](minsec_stopwatch_project/README.md) | 10 ms 측정, 모드 FSM, FND 다중화, PAUSE 애니메이션 | [발표자료](minsec_stopwatch_project/docs/minsec-stopwatch.pptx) · [영상](minsec_stopwatch_project/media/demo.mp4?raw=true) |
| [Tick 기반 버튼 디바운싱](my_btn_debounce/README.md) | 1 ms 샘플링, 약 10 ms 안정화, 상승 에지 기반 LED 토글 | [영상](my_btn_debounce/media/demo.mp4?raw=true) |
| [시프트 레지스터·FSM 패턴 검출](07_2.shift_reg_101_detect/README.md) | 1010111 검출의 두 구현 방식, 버튼 해제 이벤트 처리 | [보고서](07_2.shift_reg_101_detect/docs/report.pdf) · [시프트 영상](07_2.shift_reg_101_detect/media/shift-register-demo.mp4?raw=true) · [FSM 영상](07_2.shift_reg_101_detect/media/fsm-demo.mp4?raw=true) |
| [실행·정지 카운터](my_up_counter/README.md) | 10 ms 주기 증가, RUN/STOP 전환, 정지 중 초기화 | [보고서](my_up_counter/docs/report.pdf) · [영상](my_up_counter/media/demo.mp4?raw=true) |
| [LED 왕복 FSM](06_1.btn_debounce_10ms/README.md) | 버튼 디바운싱, 위치·방향 상태 제어 | [보고서](06_1.btn_debounce_10ms/docs/report.pdf) · [영상](06_1.btn_debounce_10ms/media/demo.mp4?raw=true) |

## 전체 실습 목록

| 단계 | 프로젝트 | 내용 | 현재 자료 / 상태 |
| --- | --- | --- | --- |
| 조합논리 | [01.gate_test.srcs](01.gate_test.srcs/README.md) | 기본 논리 게이트 | RTL · XDC · 테스트벤치 포트 수정 필요 |
| 조합논리 | [02.adder](02.adder/README.md) | 반가산기와 전가산기 | RTL · 반가산기 테스트벤치 |
| 조합논리 | [04_adder7](04_adder7/README.md) | 7비트 리플 캐리 가산기 | RTL · 테스트벤치 · 외부 가산기 소스 필요 |
| 조합논리 | [04.mux_decoder_encoder_compare](04.mux_decoder_encoder_compare/README.md) | 1비트 2:1 멀티플렉서 | RTL · 테스트벤치 |
| 조합논리 | [04.mux4bit](04.mux4bit/README.md) | 4비트 2:1 멀티플렉서 | RTL · 테스트벤치 · 보고서 |
| 조합논리 | [05.adder_subtracter](05.adder_subtracter/README.md) | 4비트 가산·감산기 | RTL · 테스트벤치 · 보고서 |
| 조합논리 | [05.decoder](05.decoder/README.md) | 디코더와 인코더 | RTL · 테스트벤치 · 보고서 · 일반 인코더 수정 필요 |
| 조합논리 | [05.gate_netlist](05.gate_netlist/README.md) | 게이트 수준 전가산기 | RTL · 전용 테스트벤치 없음 |
| 순차논리 | [06_1.btn_debounce_10ms](06_1.btn_debounce_10ms/README.md) | 버튼 디바운싱과 LED 왕복 FSM | RTL · XDC · FSM 단위 테스트벤치 · 보고서 · 영상 |
| 순차논리 | [07.moor_fsm_101detect](07.moor_fsm_101detect/README.md) | Moore FSM 101 검출기 | RTL · XDC · 보고서 · 영상 · 테스트벤치 포트 수정 필요 |
| 순차논리 | [07_2.shift_reg_101_detect](07_2.shift_reg_101_detect/README.md) | 시프트 레지스터와 FSM 패턴 검출 | RTL · XDC · 시프트 검출기 테스트벤치 · 보고서 · 영상 2개 |
| 순차논리 | [08.melay_fsm_101](08.melay_fsm_101/README.md) | Mealy FSM 101 검출기 | RTL · XDC · 보고서 · 영상 · 테스트벤치 포트 수정 필요 |
| 초기 기록 | [btn_debounce](btn_debounce/README.md) | 초기 디바운싱 실습 기록 | 초기 실습 기록 · 단독 실행 구성 미완성 |
| 순차논리 | [my_btn_debounce](my_btn_debounce/README.md) | Tick 기반 버튼 디바운싱과 LED 토글 | RTL · XDC · 테스트벤치 · 영상 · PDF 열기 오류 |
| 순차논리 | [my_up_counter](my_up_counter/README.md) | 실행·정지 가능한 16비트 자동 카운터 | RTL · XDC · 보고서 · 영상 · 전용 테스트벤치 없음 |
| 순차논리 | [minsec_stopwatch_project](minsec_stopwatch_project/README.md) | 분·초 시계와 스톱워치, 4자리 FND, 무입력 애니메이션 | RTL · XDC · 제어기 단위 테스트벤치 · 발표자료 · 영상 |

폴더와 모듈 이름의 `moor`, `melay`, `subtracter`는 기존 표기를 유지했습니다. 각 폴더는 독립 실습이며 저장소 전체를 하나의 설계로 추가하지 않습니다.

## 학습 흐름

1. 논리 게이트와 MUX로 조합회로의 입력·출력 관계를 이해합니다.
2. 반가산기 → 전가산기 → 7비트 가산기로 계층적 설계와 carry 전파를 살펴봅니다.
3. 디코더·우선순위 인코더로 코드 변환과 우선순위 처리를 구현합니다.
4. 디바운싱과 에지 검출을 통해 버튼 한 번을 하나의 입력 이벤트로 바꿉니다.
5. Moore/Mealy FSM과 시프트 레지스터로 패턴을 검출합니다.
6. 카운터에 실행·정지·초기화 제어를 결합합니다.
7. 분·초 시계와 스톱워치를 통합하고 FND 다중화·상태 표시·무입력 애니메이션으로 확장합니다.

## 실행 방법

보드 제약은 **Basys 3**, 순차회로의 입력 클럭은 **100 MHz(10 ns)** 기준입니다. Vivado 프로젝트 파일(`.xpr`), 비트스트림과 자동 빌드 스크립트는 포함되어 있지 않습니다.

1. Vivado에서 Basys 3 대상 RTL 프로젝트를 생성합니다.
2. 실습 README의 **Design Sources** 목록을 추가합니다. 예를 들어 7비트 가산기는 `02.adder`의 파일 두 개가 추가로 필요합니다.
3. 해당 **Design Top**을 지정합니다. 파일명과 모듈명이 다른 예제가 있으므로 상세 README의 이름을 사용합니다.
4. 테스트벤치는 **Simulation Sources**에 추가하고 **Simulation Top**을 별도로 설정합니다. 현재 포트 불일치가 표시된 테스트벤치는 수정이 선행되어야 합니다.
5. Behavioral Simulation에서 파형과 출력 메시지를 확인합니다. 기존 테스트 중에는 자동 판정 없이 파형만 확인하는 예제도 있습니다.
6. 보드 실행 시 해당 폴더의 XDC를 추가한 뒤 Synthesis → Implementation → Generate Bitstream → Hardware Manager 순서로 진행합니다. XDC가 없는 예제는 Top에 맞는 제약을 작성합니다.

보드 리셋은 active-high입니다. `my_btn_debounce`와 `my_up_counter`는 SW0(V17), 나머지 순차회로 보드 예제는 SW15(R2)를 사용합니다. 리셋을 1로 올렸다가 0으로 내린 뒤 동작을 확인합니다.

### 단위 시뮬레이션 예시

Icarus Verilog가 설치된 환경에서는 저장소 루트에서 아래 명령으로 7비트 시프트 검출기와 제공 테스트벤치를 실행할 수 있습니다.

```powershell
iverilog -g2012 -s tb_shift_register -o "$env:TEMP/fpga-pattern-sim.vvp" ./07_2.shift_reg_101_detect/sources_1/my_shiftreg_1010111_detect.v ./07_2.shift_reg_101_detect/sim_1/tb_shift_register.v
vvp "$env:TEMP/fpga-pattern-sim.vvp"
```

기대 메시지는 `TEST PASS!`입니다. 버튼 디바운서와 FSM 대안 구현까지 검증하는 테스트는 아닙니다.

## 파일 구성과 자료 안내

```text
실습 폴더/
├── README.md      # 동작, 실행 구성, 검증 범위
├── sources_1/     # Verilog RTL
├── sim_1/         # 테스트벤치 (있는 경우)
├── constrs_1/     # 핀·타이밍 제약 (있는 경우)
├── docs/          # 제공된 PDF 보고서·PPTX 발표자료 사본 (있는 경우)
└── media/         # H.264 MP4와 GIF 미리보기 (있는 경우)
```

제공 자료는 PDF 보고서 9개, PPTX 발표자료 1개와 영상 8개이며, 링크를 공유할 수 있도록 저장소 안에 복사했습니다. 각 실습 README에 원본 파일명을 기록했습니다. 각 상세 README에는 전체 동작을 볼 수 있는 GIF 미리보기를 넣었습니다. 영상 링크는 MP4 원본 데이터 열기·다운로드용입니다. 브라우저에서 다운로드가 시작되면 저장한 파일을 재생하세요. MP4는 H.264/AAC로 변환했으며 제공 원본은 저장소 밖에 보존되어 있습니다. 다운로드 폴더에서 찾지 못한 영상은 프로젝트 상위 폴더의 동일 이름 파일을 사용했습니다.

`my_btn_debounce` PDF는 읽기·렌더링 오류가 있어 원본 보존용으로 연결했습니다. 나머지 보고서 및 시연 자료는 기존 구현 기록이며 현재 RTL과 버전이 일치한다는 보장은 없습니다.

## 검증 범위

이 문서는 RTL·테스트벤치·XDC, 제공 보고서·발표자료와 영상 미리보기를 확인해 작성했습니다. 이번 문서화 과정에서 시뮬레이션, 합성, 타이밍 분석이나 보드 프로그램을 다시 수행하지 않았습니다. 자료 보유 여부와 현재 자동 테스트 통과 여부는 구분합니다.

중복 모듈, 테스트벤치 포트 불일치, 미완성 예제 등 실행에 영향을 주는 항목은 각 실습의 **현재 상태와 주의사항**에 정리했습니다. Verilog 소스 자체는 이번 문서화에서 변경하지 않았습니다.
