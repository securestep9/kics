package queries

import (
	"testing"

	"github.com/checkmarxDev/ice/pkg/model"
)

func Test_Insufficient_Password_Length(t *testing.T) {
	const query = "Insufficient_Password_Length.rego"

	checkQuery(
		t,
		query,
		queryTerraformFile(query),
		[]model.Vulnerability{
			{
				Line:      13,
				Severity:  model.SeverityHigh,
				QueryName: "Insufficient password length",
			},
			{
				Line:      9,
				Severity:  model.SeverityHigh,
				QueryName: "Insufficient password length",
			},
		},
	)
}

func Test_Insufficient_Password_Length_Success(t *testing.T) {
	const query = "Insufficient_Password_Length.rego"

	checkQuery(
		t,
		query,
		queryTerraformSuccessFile(query),
		[]model.Vulnerability{},
	)
}