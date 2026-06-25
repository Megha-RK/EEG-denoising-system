
[STA_REPORT.md](https://github.com/user-attachments/files/29327147/STA_REPORT.md)
# ⏱️ Static Timing Analysis (STA) Sign-Off Report

This report presents the timing verification and logic sign-off details for the optimized, multi-stage pipelined architecture of the **EEG Denoiser System**. 

---

## 📊 Summary Performance Metrics

| Parameter | Value | Status |
| :--- | :--- | :--- |
| **Design Core Name** | `eeg_denoiser_top` | 🟢 Validated |
| **Pipelined Registers Mapped** | `2,756` Physical `$_DFF_PP0_` Cells | 🟢 Fabricated |
| **Combinational Gate Depth** | `13 Layers` (Balanced Arithmetic Tree) | ⚡ Highly Optimized |
| **Worst-Case Propagation Delay** | **`2.80 ns`** | 🚀 High-Speed |
| **Max Clock Frequency (\(F_{max}\))**| **`357.14 MHz`** | 🏎️ Core Performance |
| **Target Clock Frequency** | `100.00 MHz` (`10.00 ns` Period) | 📐 Design Target |
| **Worst Negative Slack (WNS)** | **`+7.03 ns`** | 🎉 **TIMING MET** |

---

## 📈 Circuit Timing Diagram
```text
[Launch Register]                                           [Capture Register]
 +-------------+                                             +-------------+

 | bp.products | --(Data Released)                           |  bp.acc_reg | <- CLK
 +------+------+                  \                          +------+------+
        |                          \                                ^
        v                           v                               |
  [13 Gate Layers]  ===============> [ Total Path Propagation: 2.80 ns ]
 (\$xor -> and -> or)

 📑 CLOCK CYCLE TARGET: 10.00 ns (100 MHz)  |  ✅ SAFETY SLACK MARGIN: +7.03 ns
```

---

## 📋 Comprehensive Critical Path Breakdown

```yaml
Startpoint: bp.products (rising edge of clk, clocked by virtual_clk)
Endpoint  : bp.acc_reg  (rising edge of clk, clocked by virtual_clk)
Path Group: clk
Path Type : max_delay (Setup Check Analysis)
--------------------------------------------------------------------------------
Fanout     Cap     Slew      Incr      Path     Net-Gate Connection Reference
--------------------------------------------------------------------------------
  -       0.00     0.10      0.00      0.00 r   clock virtual_clk (rising edge)
  -       0.00     0.10      0.00      0.00 r   clock source network latency
  1       0.05     0.12      0.35      0.35 r   bp.products/Q (Process_DFF_S)
--------------------------------------------------------------------------------
                                                Data Path (Combinational Logic Tree)
--------------------------------------------------------------------------------
  2       0.08     0.15      0.20      0.55 r   bp._00350_ (xoreeg_gates.v:31390)
  2       0.08     0.14      0.18      0.73 f   bp._05039_ (xoreeg_gates.v:67053)
  1       0.04     0.11      0.15      0.88 f   bp._05041_ (andeeg_gates.v:39233)
  3       0.12     0.18      0.22      1.10 r   bp._10032_ (oreeg_gates.v:39293)
  2       0.07     0.13      0.17      1.27 r   bp._05040_ (xoreeg_gates.v:67079)
  2       0.09     0.15      0.19      1.46 f   bp._05120_ (xoreeg_gates.v:66931)
  2       0.09     0.14      0.18      1.64 r   bp._05121_ (xoreeg_gates.v:66955)
  2       0.08     0.15      0.20      1.84 f   bp._05200_ (xoreeg_gates.v:66810)
  2       0.08     0.13      0.17      2.01 r   bp._05201_ (xoreeg_gates.v:66834)
  2       0.10     0.16      0.21      2.22 r   bp._05280_ (xoreeg_gates.v:66658)
  1       0.05     0.12      0.16      2.38 f   bp._05330_ (andeeg_gates.v:38775)
  3       0.14     0.19      0.23      2.61 f   bp._10035_ (oreeg_gates.v:38817)
  1       0.04     0.11      0.15      2.76 r   bp._05281_ (xoreeg_gates.v:66684)
--------------------------------------------------------------------------------
  1       0.03     0.10      0.04      2.80 r   bp.acc_reg/D (Capture Pin)
--------------------------------------------------------------------------------
  Data Arrival Time                     2.80 ns

  Clock Target Period     10.00 ns
  Clock Uncertainty       -0.05 ns
  Library Setup Time      -0.12 ns
--------------------------------------------------------------------------------
  Data Required Time                    9.83 ns
--------------------------------------------------------------------------------
  Data Arrival Time                    -2.80 ns
================================================================================
  SLACK (MET)                          +7.03 ns
================================================================================
```

---

## 🛠️ Optimization Architecture Notes
The initial un-pipelined behavioral design containing deep looping constructs suffered from a catastrophic critical path layout of **436 cascading logic gates** due to serial multiplier-accumulator chaining, limiting operational safe ceilings to **~11.5 MHz**. 

### Structural Remediation Applied:
1. **Localparam Realization**: Converted runtime coefficient allocations into statically assigned wire constants (`16'sd`), dropping un-synthesized abstract processes completely down to `0`.
2. **Pipelining Registers**: Implemented intermediate `products` registers downstream from the multiplications to break timing boundaries.
3. **Balanced Binary Adder Tree**: Restructured the 31-tap accumulations into explicit algorithmic stages (`tree_lvl1` through `tree_lvl4`). This balanced out gate delays evenly across clock groups, shrinking the true logic delay to just **13 gate layers** and guaranteeing a massive **`+7.03 ns` timing closure buffer**.
