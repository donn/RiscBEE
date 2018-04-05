package riscbee

import chisel3._
import chisel3.util._


class ALU extends Module {
  val io = IO(new Bundle {
    val A    = Input(UInt(32.W))
    val B    = Input(UInt(32.W))
    val switch = Input(Bool(1.W))
    val operation  = Input(UInt(3.W))
    val O  = Output(UInt(32.W))
    val Z = Output(UInt(1.W))
    val N = Output(UInt(1.W))
    val C = Output(UInt(1.W))
    val V = Output(UInt(1.W))
  })
  //create an array of FullAdders
  val add = Wire(Vec(32, UInt()))
  val sll = Wire(Vec(32, UInt()))
  val shift = Wire(Vec(32, UInt()))
  val slt = Wire(Vec(32, UInt()))
  val sltu = Wire(Vec(32, UInt()))
  val lxor = Wire(Vec(32, UInt()))
  val srl = Wire(Vec(32, UInt()))
  val lor = Wire(Vec(32, UInt()))
  val land = Wire(Vec(32, UInt()))

  val c = Wire(Vec(1, UInt())
  val v = Wire(Vec(1, UInt())

  val signedA = Wire(Vec(32, SInt())
  val signedB = Wire(Vec(32, SInt())
  
  signedA := io.A
  signedB := io.B

  Cat(c, add) := switch ? io.A -& io.B : io.A +& io.B
  v := c ^ (add(31) ^ io.A(31) ^ io.B(31)
  sll := io.A << io.B(5, 0)
  slt := (signedA < signedB) ? 1.U : 0.U
  sltu := (io.A < io.B) ? 1.U: 0.U
  lxor := io.A ^ io.B
  srl = switch ? signedA >> signedB(5, 0) : io.A >> io.B(5, 0)
  lor = io.A | io.B
  land = io.A & io.B

  io,O := MuxLookup(operation, add, Array(1.U -> sll, 2.U -> slt, 3.U -> sltu, 4.U -> lxor, 5.U -> srl, 6.U -> lor, 7.U -> land))

  Cat(io.C, io.V) := (operation === 0.U) ? Cat(c, v): (0.U)
  io.Z := (io.O === 0.U) ? 1.U : 0.U
  io.N := O(31)
}