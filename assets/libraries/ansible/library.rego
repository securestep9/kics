package generic.ansible

getTasks(document) = result {
	result := [body | playbook := document.playbooks[0]; body := playbook.tasks]
	count(result) != 0
} else = result {
	result := [body | playbook := document.playbooks[_]; body := playbook]
	count(result) != 0
}

checkState(task) {
	state := object.get(task, "state", "undefined")
	state != "absent"
}

isAnsibleTrue(answer) {
	lower(answer) == "yes"
} else {
	lower(answer) == "true"
} else {
	answer == true
}

isAnsibleFalse(answer) {
	lower(answer) == "no"
} else {
	lower(answer) == "false"
} else {
	answer == false
}

IsMissingAttribute(task) {
	object.get(task, "settings", "undefined") == "undefined"
}

IsMissingAttribute(task) {
	object.get(task.settings, "databaseFlags", "undefined") == "undefined"
}

IsFlagOff(dbFlags, flagName) {
	dbFlags[j].name == flagName
	lower(dbFlags[j].value) == "off"
}

checkValue(val) {
	count(val) == 0
}

checkValue(val) {
	val == null
}

check_database_flags_content(database_flags, flagName, flagValue) {
	database_flags[x].name == flagName
	database_flags[x].value != flagValue
}

check_database_flags_content(database_flags, flagName, flagValue) {
	database_flags.name == flagName
	database_flags.value != flagValue
}

isDirIngress(instance) {
	instance.direction == "INGRESS"
} else {
	not instance.direction
} else = false {
	true
}

allowsPort(allowed, port) {
	portNumber := to_number(port)
	some i
	contains(allowed.ports[i], "-")
	port_bounds := split(allowed.ports[i], "-")
	low := port_bounds[0]
	high := port_bounds[1]
	isPortInBounds(low, high, portNumber)
} else {
	allowed.ports[_] == port
} else = false {
	true
}

isPortInBounds(low, high, portNumber) {
	to_number(low) <= portNumber
	to_number(high) >= portNumber
} else = false {
	true
}
