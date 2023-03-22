package release

import (
	"encoding/json"
	"fmt"
)

type Asset struct {
	Name      string `json:"Name,omitempty"`
	Label     string `json:"Label,omitempty"`
	MediaType string `json:"MediaType,omitempty"`
	Path      string `json:"Path,omitempty"`
}

func ConfigureAssetParameters(byString string) []Asset {
	asset := []Asset{}
	err := json.Unmarshal([]byte(byString), &asset)

	if err != nil {
		fmt.Println("Cannot Parse JSON From Command Line....", err)
	}
	return asset
}
