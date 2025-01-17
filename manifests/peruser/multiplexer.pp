# @summary
#   Checks if an Apache module has a class.
#
# If Apache has a class, it includes that class. If it does not, it passes the module name to the `apache::mod` defined type.
#
# @api private
define apache::peruser::multiplexer (
  String $user            = $apache::user,
  String $group           = $apache::group,
  Optional[String] $file  = undef,
) {
  if ! $file {
    $filename = "${name}.conf"
  } else {
    $filename = $file
  }
  file { "${apache::mod_dir}/peruser/multiplexers/${filename}":
    ensure  => file,
    content => "Multiplexer ${user} ${group}\n",
    require => File["${apache::mod_dir}/peruser/multiplexers"],
    notify  => Class['apache::service'],
  }
}
