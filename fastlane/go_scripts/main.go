package main

import (
	"context"
	"fmt"
	"log"
	"main/auth"
	"main/issues"
	"main/pulls"
	"os"

	"github.com/joho/godotenv"
)

func main() {
	envError := godotenv.Load(".env")

	if envError != nil {
		log.Fatal("Cannot read .env file")
	}

	ctx := context.Background()
	client := auth.GithubClient(os.Args[3], ctx)

	switch os.Args[1] {
	case "createComment":
		buildInfo := configureBuildInfo(os.Args[2])
		formatedBuildInfo := buildInfo.formatted_build_info_git()
		issues.CreateComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.PullNumber, formatedBuildInfo, *client)
		pulls.LinkPullRequest(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.Issue, buildInfo.PullNumber, *client)
	case "getIssues":
		issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
	default:
		fmt.Println("Unknown command")
	}
}
