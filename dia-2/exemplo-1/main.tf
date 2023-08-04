resource "random_string" "rnd" {
  length = 16
}

output "string_rnd" {
  value = random_string.rnd.result
}