package main

import (
	"context"
	"fmt"
	"log"
	"main/auth"
	"main/issues"
	"os"

	"github.com/joho/godotenv"
)

func main() {
	envError := godotenv.Load(".env")

	if envError != nil {
		log.Fatal("Cannot read .env file")
	}

	ctx := context.Background()

	switch os.Args[1] {
	case "createComment":
		buildInfo := configureBuildInfo(os.Args[2])
		client := auth.GithubClient(os.Args[3], ctx)
		issues.CreateIssueComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.Issue, buildInfo.formatted_build_info_git(), *client)
	case "getIssues":
		client := auth.GithubClient(os.Args[3], ctx)
		issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
	default:
		fmt.Println("Unknown command")
	}
}
