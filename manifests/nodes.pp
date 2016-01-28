#node 'raspberrypi.home.bs' {
#   include apache2
#   include ntpdate
#  include common
#}
#
#node 'precise64.home.bs' {
#  include apache2
#  include common
#  include ntp
#  include ntpdate
#}
#node 'web2.home.bs' {
#   include apache2
#  include common
#}
