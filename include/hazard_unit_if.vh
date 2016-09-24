`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

interface hazard_unit_if;

  //inputs
  logic dhit, ihit;
  logic memWEN, memREN;

  //outputs
  logic decode_en, execute_en, fetch_en, memory_en, deassert;

  modport haz (
    input   dhit, ihit, memWEN, memREN,
    output  decode_en, execute_en, fetch_en, memory_en, deassert
  );

endinterface

`endif
