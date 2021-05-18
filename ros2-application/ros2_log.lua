-- Chisel description
description = "ROS events logging"
short_description = "ROS events logging"
category = "misc"
local config = require "settings_ros2"

-- Chisel argument list
args = {}

json = require ("dkjson")

-- Initialization callback
function on_init()
	-- Needed fields request
	
	-- Incremental event number
	evt_num = chisel.request_field("evt.num")
	-- Event timestamp
    datetime = chisel.request_field("evt.datetime")
	
	-- Container id
	container_id = chisel.request_field("container.id")
	-- Container name
	container_name = chisel.request_field("container.name")

	-- Name of the executable generating the event
	proc_name = chisel.request_field("proc.name")
	-- Id of the process generating the event
	proc_pid = chisel.request_field("proc.pid")
	-- The environment variables of the process generating the event
	proc_env = chisel.request_field("proc.env")

	-- User name
	user_name = chisel.request_field("user.name")

	-- Name of the event
    evt_type = chisel.request_field("evt.type")
	-- Name of the event
    evt_arg_data = chisel.request_field("evt.arg.data")

	-- Capture the first 56000 bytes of each I/O buffer
    sysdig.set_snaplen(56000)
	
	-- Set settings filter
    chisel.set_filter(config.filter)
	return true
end

-- Event parsing callback
function on_event()

	-- local variables to fields parsing
	local evt_num = evt.field(evt_num)
	local datetime = evt.field(datetime)

	local container_id = evt.field(container_id)
	local container_name = evt.field(container_name)

	local proc_name = evt.field(proc_name)
	local proc_pid = evt.field(proc_pid)
	local proc_env = evt.field(proc_env)

	local ros_distro
	local ros_localhost_only

	if not (proc_env == nil) then
		ros_distro = string.match(proc_env, "ROS_DISTRO=(%S+)")
		ros_localhost_only = string.match(proc_env, "ROS_LOCALHOST_ONLY=(%S+)")
	end
	
	local user_name = evt.field(user_name)

	local evt_type = evt.field(evt_type)
	local evt_arg_data = evt.field(evt_arg_data)
	
	-- Node name
	local node_name
	
	-- Line and function name in python error messages "line <line_numer>, in <function_name>."
	local line
	local function_name

	-- pattern matching for node name, line and function name
	if not (evt_arg_data == nil) then
		split_arg_data = Split(evt_arg_data, " ")
		if not (split_arg_data[3] == nil) then
			node_name = string.match(split_arg_data[3],"%[(%S+)]:")
		end
		line,function_name = string.match(evt_arg_data, "line (%d+), in (%S+).")

	end

	-- Log level
	local log_level_dict = {'DEBUG','INFO','WARN','ERROR','FATAL'}
	if not (evt_arg_data == nil) then
		for _,v in pairs( log_level_dict ) do
			if evt_arg_data:find( v ) then
				log_level = v
				break
			end
		end
	end
	
	-- JSON output encoding	
	print(json.encode({evt_num=evt_num, datetime=datetime, container_id=container_id, container_name=container_name, proc_name=proc_name, proc_pid=proc_pid, evt_type=evt_type, evt_arg_data=evt_arg_data, user_name=user_name, ros_distro=ros_distro, ros_locahost_only=ros_localhost_only, log_level=log_level, line=line, function_name=function_name, node_name=node_name}))
	return true
end

-- End of capture callback
function on_capture_end()

	return true
end

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
