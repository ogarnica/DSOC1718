import core::*;

class general_monitor extends uvm_monitor;
 
  // Virtual Interface
  virtual bfm bfm;
 
  uvm_analysis_port #(general_seq_item) item_collected_port;
 
  // Placeholder to capture transaction information.
  general_seq_item trans_collected;
 
  `uvm_component_utils(general_monitor)
 
  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual bfm)::get(this, "", "bfm", bfm))
       `uvm_fatal("NO_bfm",{"virtual interface must be set for: ",get_full_name(),".bfm"});
  endfunction: build_phase
 
  // run phase
  virtual task run_phase(uvm_phase phase);
    item_collected_port.write(trans_collected);
  endtask : run_phase
 
endclass : general_monitor