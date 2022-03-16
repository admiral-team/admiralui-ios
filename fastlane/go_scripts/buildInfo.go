package main

type BuildInfo struct {
	Platform         string `json:"platform,omitempty"`
	Build_id         string `json:"BuildID,omitempty"`
	Version          string `json:"Version,omitempty"`
	Internal_version string `json:"InternalVersion,omitempty"`
	Short_version    string `json:"ShortVersion,omitempty"`
	Download_url     string `json:"download_url,omitempty"`
	Install_url      string `json:"InstallURL,omitempty"`
	Build_url        string `json:"build_url,omitempty"`
	Branch_name      string `json:"BranchName,omitempty"`
	Issue            string `json:"Issue,omitempty"`
}

func formatted_build_info_git(buildInfo BuildInfo) string {
	var resultString string
	if buildInfo.Platform != "" {
		resultString += "Platform: " + buildInfo.Platform + "\n"
	}
	if buildInfo.Build_id != "" {
		resultString += "Build ID: " + buildInfo.Build_id + "\n"
	}
	if buildInfo.Version != "" {
		resultString += "Version: " + buildInfo.Version + "\n"
	}
	if buildInfo.Internal_version != "" {
		resultString += "Internal Version: " + buildInfo.Internal_version + "\n"
	}
	if buildInfo.Short_version != "" {
		resultString += "Short Version: " + buildInfo.Short_version + "\n"
	}
	if buildInfo.Branch_name != "" {
		resultString += "Branch Name: " + buildInfo.Branch_name + "\n"
	}
	if buildInfo.Build_url != "" {
		resultString += "Install URL: "+ buildInfo.Build_url + "\n"
	}
	return resultString
}
