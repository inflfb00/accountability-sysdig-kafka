-- Process, syscalls and data filters for ROS2 framework
config = {
   filter="(" ..
	" proc.name=ros2" ..
	" or proc.name contains gzclient" ..
	" or proc.name contains gzserver" ..
	" or proc.name contains rviz2" ..
	" or proc.name contains talker" ..
	" or proc.name=listener)" ..
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
