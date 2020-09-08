package Cx

#CxPragma "$.resource.aws_launch_configuration"

result [ getMetadata({"id" : input.All[i].CxId, "data" : [block], "search": "block_device"}) ] {
	some i    
    enc = input.All[i].resource.aws_launch_configuration[name][block].encrypted
    enc = false
    not contains(block, "ephemeral")
    contains(block, "block_device")
}

getMetadata(id) = res {
	some cnt
    input.All[cnt].CxId = id.id
    res := {
        "id" : input.All[cnt].CxId,
        "file" : input.All[cnt].CxFile,
        "name" : "Not encrypted data in launch configuration",
        "severity": "Medium",
        "cnt" : cnt,
        "search": id.search,
        "data" : id.data
    }
}