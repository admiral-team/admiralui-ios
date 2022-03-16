package auth

import (
	"context"

	"github.com/google/go-github/github"
	"golang.org/x/oauth2"
)

func GithubClient(byToken string, ctx context.Context) *github.Client {
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: byToken},
	)
	tc := oauth2.NewClient(ctx, ts)

	client := github.NewClient(tc)
	return client
}
