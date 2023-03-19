package release

import (
	"context"
	"log"

	"github.com/google/go-github/v43/github"
	"golang.org/x/oauth2"
)

func CreateRelease(ctx context.Context, owner, repo string, tag string, token string) {
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	targetCommit := "feature/VIS-741-send-assets"
	tagName := "12.0.0"
	autoGenerateNotes := true
	name := "AdmiralUIKit"
	url := "http://www.google.com"
	releaseAsset := github.ReleaseAsset{
		Label: &name,
		Name:  &name,
		URL:   &url,
	}
	var releaseAssets []*github.ReleaseAsset
	releaseAssets[0] = &releaseAsset

	release := github.RepositoryRelease{}
	release.TagName = &tagName
	release.TargetCommitish = &targetCommit
	release.Name = &tag
	release.GenerateReleaseNotes = &autoGenerateNotes
	release.Assets = releaseAssets

	_, _, error := client.Repositories.CreateRelease(ctx, owner, repo, &release)

	if error != nil {
		log.Fatal(error)
		return
	}
}
