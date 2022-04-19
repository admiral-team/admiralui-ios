package release

import (
	"context"
	"fmt"
	"log"

	"github.com/google/go-github/v43/github"
	"golang.org/x/oauth2"
)

func CreateRelease(
	ctx context.Context,
	owner, repo string,
	token string,
	tag string,
	buildId string,
	buildUrl string,
	internalVersion string) {

	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	targetCommit := "main"
	autoGenerateNotes := true
	body := "## Demo App \n\nVersion %s (%s) ([%s](%s))"
	body = fmt.Sprintf(body, tag, internalVersion, buildId, buildUrl)

	var release = github.RepositoryRelease{}
	release.TagName = &tag
	release.TargetCommitish = &targetCommit
	release.Name = &tag
	release.Body = &body
	release.GenerateReleaseNotes = &autoGenerateNotes

	_, _, createError := client.Repositories.CreateRelease(ctx, owner, repo, &release)

	if createError != nil {
		log.Fatal(createError)
		return
	}
}
