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
	// var id int64 = 123512
	// url := "https://github.com/admiral-team/admiralui-ios/blob/feature/741-script-xcframework/Examples/ExampleSPM/ExampleSPM/ContentView.swift"
	releaseAsset := github.ReleaseAsset{
		Label: &name,
	}
	releaseAssets := []*github.ReleaseAsset{
		&releaseAsset,
	}

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
