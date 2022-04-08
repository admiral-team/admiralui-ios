package pulls

import (
	"context"
	"fmt"
	"log"
	"os/exec"

	"github.com/google/go-github/github"
)

func LinkPullRequest(ctx context.Context, owner string, repo string, issueNumber int, pullNumber int, client github.Client) {
	pullRequest, _, error := client.PullRequests.Get(ctx, owner, repo, pullNumber)

	if error != nil {
		log.Fatal(error)
	}

	fmt.Println(*pullRequest.Head.Ref)
	var commitsCount int = *pullRequest.Commits

	if commitsCount == 1 {
		commitCommand := fmt.Sprintf("git commit --allow-empty --amend -m \"resolve #%d\"", issueNumber)
		pushCommand := "git push --force origin " + *pullRequest.Head.Ref
		cmd := exec.Command("sh", "-c", commitCommand+" && "+pushCommand)
		stdout, err := cmd.Output()

		if err != nil {
			log.Fatal(err)
			return
		}

		fmt.Println(string(stdout))
	}
}
