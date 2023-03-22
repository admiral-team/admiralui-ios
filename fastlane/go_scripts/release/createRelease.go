package release

import (
	"context"
	"fmt"
	"os"

	"github.com/google/go-github/v43/github"
	"golang.org/x/oauth2"
)

func CreateRelease(ctx context.Context, owner, repo string, tag string, token string, assets []Asset) {
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	targetCommit := "main"
	autoGenerateNotes := true

	release := github.RepositoryRelease{}
	release.TagName = &tag
	release.TargetCommitish = &targetCommit
	release.Name = &tag
	release.GenerateReleaseNotes = &autoGenerateNotes

	releaseGithub, _, _ := client.Repositories.CreateRelease(ctx, owner, repo, &release)
	fmt.Printf("Release created\n")

	for _, asset := range assets {
		filePath := asset.Path

		file, err := os.Open(filePath)
		if err != nil {
			fmt.Printf("Failed to open file: %v\n", err)
		}
		defer file.Close()

		githubOption := github.UploadOptions{
			Name:      asset.Name,
			Label:     asset.Label,
			MediaType: asset.Path,
		}
		_, _, err = client.Repositories.UploadReleaseAsset(ctx, owner, repo, *releaseGithub.ID, &githubOption, file)

		if err != nil {
			fmt.Printf("Failed to upload release asset: %v\n", err)
		} else {
			fmt.Printf("Release asset %v added\n", asset.Name)
		}
	}
}
