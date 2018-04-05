// See LICENSE for license details.

package riscbee

import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class RiscBEEUnitTester(c: RiscBEE) extends PeekPokeTester(c) {

}

/**
  * This is a trivial example of how to run this Specification
  * From within sbt use:
  * {{{
  * testOnly example.test.RiscBEETester
  * }}}
  * From a terminal shell use:
  * {{{
  * sbt 'testOnly example.test.RiscBEETester'
  * }}}
  */
class RiscBEETester extends ChiselFlatSpec {
  private val backendNames = if(firrtl.FileUtils.isCommandAvailable("verilator")) {
    Array("firrtl", "verilator")
  }
  else {
    Array("firrtl")
  }
  for ( backendName <- backendNames ) {
    "RiscBEE" should s"calculate proper greatest common denominator (with $backendName)" in {
      Driver(() => new RiscBEE, backendName) {
        c => new RiscBEEUnitTester(c)
      } should be (true)
    }
  }

  "Basic test using Driver.execute" should "be used as an alternative way to run specification" in {
    iotesters.Driver.execute(Array(), () => new RiscBEE) {
      c => new RiscBEEUnitTester(c)
    } should be (true)
  }

  "using --backend-name verilator" should "be an alternative way to run using verilator" in {
    if(backendNames.contains("verilator")) {
      iotesters.Driver.execute(Array("--backend-name", "verilator"), () => new RiscBEE) {
        c => new RiscBEEUnitTester(c)
      } should be(true)
    }
  }

  "running with --is-verbose" should "show more about what's going on in your tester" in {
    iotesters.Driver.execute(Array("--is-verbose"), () => new RiscBEE) {
      c => new RiscBEEUnitTester(c)
    } should be(true)
  }

  "running with --fint-write-vcd" should "create a vcd file from your test" in {
    iotesters.Driver.execute(Array("--fint-write-vcd"), () => new RiscBEE) {
      c => new RiscBEEUnitTester(c)
    } should be(true)
  }

  "using --help" should s"show the many options available" in {
    iotesters.Driver.execute(Array("--help"), () => new RiscBEE) {
      c => new RiscBEEUnitTester(c)
    } should be (true)
  }
}
