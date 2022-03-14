package issues

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"

	"github.com/google/go-github/github"
)

func GetIssues(ctx context.Context, owner string, repo string, client github.Client) {
	var state string

	fmt.Print("Enter state(open, closed, all) to get issues: ")
	fmt.Scanf("%s", &state)

	if state == "" {
		state = "all"
	}

	options := github.IssueListByRepoOptions{State: state}

	issuesList, _, error := client.Issues.ListByRepo(ctx, owner, repo, &options)

	if error != nil {
		log.Fatal(error)
	}

	file, _ := json.MarshalIndent(issuesList, "", " ")

	_ = ioutil.WriteFile("issues/data/issues.json", file, 0644)
}
