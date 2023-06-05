include "root" {
  path = find_in_parent_folders()
}

dependencies "component1" {
  paths = ["../component1"]
}

/*
inputs = merge(
  local.local_inputs.inputs,
  {
    var1   = dependency.component1.outputs.var1
  }
)*/