include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../component1"]
}

dependency "component1" {
  config_path = "../component1"

  #mock_outputs_allowed_terraform_commands = ["validate"]
  #mock_outputs = {
  #  var1 = "xxxx"
  #}
}

/*inputs = merge(
  local.local_inputs.inputs,
  {
    var1   = dependency.component1.outputs.var1
  }
)*/