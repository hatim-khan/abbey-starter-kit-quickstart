resource "abbey_demo" "grant_read_write_access_one" {
  permission = "read_write"
  email      = "hat@abbey.io"
}
resource "abbey_demo" "grant_read_write_access_three" {
  permission = "read_write"
  email = "hat@abbey.io"
}
