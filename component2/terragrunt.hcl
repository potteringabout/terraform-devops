include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../component1"]
}

dependency "component1" {
  config_path = "../component1"
}

/*inputs = merge(
  local.local_inputs.inputs,
  {
    var1   = dependency.component1.outputs.var1
  }
)*/