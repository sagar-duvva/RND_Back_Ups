output "allowed_location_output_0" {
  value = var.allowed_location[0] # List Constrain Variable
}

output "tagsoutput" {
  value = var.rTags # Map Constrain Variable
}


output "tupleout_0" {
  value = [element(var.network_config, 0)]
}

output "tupleConcatinate_Val1_Val2" {
  value = ["${element(var.network_config, 1)}/${element(var.network_config, 2)}"] 
}