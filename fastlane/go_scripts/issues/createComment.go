package issues

import (
	"context"
	"fmt"
	"log"
	"strings"

	"github.com/google/go-github/github"
)

func CreateComment(ctx context.Context, owner string, repo string, issueNumber int, body []string, client github.Client) {
	if len(body) == 0 {
		log.Fatal("Cannot build info form zero parameters")
		return
	}

	splitString := strings.Join(body, " ")
	stringsArray := strings.Split(splitString, ",")
	var resultBody string

	for _, s := range stringsArray {
		resultBody += s + "\n"
	}

	issueComment := github.IssueComment{Body: &resultBody}
	gotIssue, response, commentError := client.Issues.CreateComment(ctx, owner, repo, issueNumber, &issueComment)

	if commentError != nil {
		log.Fatal(commentError)
	}
	fmt.Println("GOT Response from git", response, gotIssue)
}
