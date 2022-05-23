package pullRequests

import (
	"context"
	"fmt"
	"log"
	"strings"

	"github.com/google/go-github/github"
)

func LinkPullRequest(ctx context.Context, owner string, repo string, pullNumber int, issueNumber string, client github.Client) {
	pull, _, error := client.PullRequests.Get(ctx, owner, repo, pullNumber)

	if error != nil {
		log.Fatal(error)
	}

	if !strings.Contains(*pull.Body, "Closes #") {
		closeAction := fmt.Sprintf("%s%s", "# Задача Closes #", issueNumber)
		var body string = strings.Replace(*pull.Body, "# Задача", closeAction, 1)

		pullRequest := github.PullRequest{Number: &pullNumber, Body: &body}
		pullRequest.Number = &pullNumber
		pullRequest.Body = &body

		_, _, linkError := client.PullRequests.Edit(ctx, owner, repo, pullNumber, &pullRequest)

		if linkError != nil {
			log.Fatal(error)
		}
	}
}
