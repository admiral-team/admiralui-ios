package release

import (
	"context"
	"fmt"
	"log"

	"github.com/google/go-github/v43/github"
	"golang.org/x/oauth2"
)

func CreateRelease(ctx context.Context, owner, repo string, tag string, token string) bool {
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	targetCommit := "main"
	autoGenerateNotes := true

	fmt.Println("tag", tag)

	release := github.RepositoryRelease{}
	release.TagName = &tag
	release.TargetCommitish = &targetCommit
	release.Name = &tag
	release.GenerateReleaseNotes = &autoGenerateNotes

	_, _, error := client.Repositories.CreateRelease(ctx, owner, repo, &release)

	if error != nil {
		log.Fatal("error", error)
		return false
	} else {
		return true
	}
}
