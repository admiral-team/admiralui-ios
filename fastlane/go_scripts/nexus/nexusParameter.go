package nexus

import (
	"encoding/json"
	"fmt"
)

type NexusParameter struct {
	Repository         string `json:"Repository,omitempty"`
	GroupId            string `json:"GroupId,omitempty"`
	ArtifactId         string `json:"ArtifactId,omitempty"`
	Version            string `json:"Version,omitempty"`
	ZipedFrameworkPath string `json:"ZipedFrameworkPath,omitempty"`
	Extension          string `json:"Extension,omitempty"`
	NexusUrl           string `json:"NexusUrl,omitempty"`
	Username           string `json:"Username,omitempty"`
	Password           string `json:"Password,omitempty"`
}

func ConfigureNexusParameters(byString string) NexusParameter {
	buildInfo := NexusParameter{}
	err := json.Unmarshal([]byte(byString), &buildInfo)

	if err != nil {
		fmt.Println("Cannot Parse JSON From Command Line....", err)
	}
	return buildInfo
}
