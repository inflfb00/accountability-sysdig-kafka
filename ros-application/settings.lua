-- Process, syscalls and data filters for ROS framework
config = {
   filter="(" ..
	"proc.name contains *.py" ..
	" or proc.name=amcl" ..
	" or proc.name=bash" ..
	" or proc.name=catkin_find" ..
	" or proc.name=gzclient" ..
	" or proc.name=gzserver" ..
	" or proc.name=map_server" ..
	" or proc.name=python" ..
	" or proc.name=roscore" ..
	" or proc.name=rosmaster" ..
	" or proc.name=rosout" ..
	" or proc.name=rostopic" ..
	" or proc.name=rosversion" ..
	" or proc.name=rviz)" ..
	" and (evt.type=write" ..
	" or evt.type=clone" ..
	" or evt.type=connect" ..
	" or evt.type=accept" ..
	" or evt.type=sendto" ..
	" or evt.type=setsockopt" ..
	" or evt.type=recvfrom" ..
	" or evt.type=execve" ..
	")" ..
	" and (" ..
	" evt.arg.data contains INFO" ..
	" or evt.arg.data contains ERROR" ..
	" or evt.arg.data contains WARN" ..
	" or evt.arg.data contains DEBUG" ..
    " or evt.arg.data contains File" ..
	" or evt.arg.fd contains :" ..
	")"
}return config
