package issues

import (
	"context"
	"fmt"
	"log"

	"github.com/google/go-github/github"
)

func CreateComment(ctx context.Context, owner string, repo string, number int, body string, client github.Client) {
	if len(body) == 0 {
		log.Fatal("Cannot build info form zero parameters")
		return
	}

	issueComment := github.IssueComment{Body: &body}
	issues, _, commentError := client.Issues.CreateComment(ctx, owner, repo, number, &issueComment)

	if commentError != nil {
		log.Fatal(commentError)
	}
	fmt.Println("GOT Response from git", issues)
}
