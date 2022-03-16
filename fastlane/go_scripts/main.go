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
	envSecretError := godotenv.Load(".env.secret")

	if envError != nil || envSecretError != nil {
		log.Fatal("Cannot read .env file")
	}

	ctx := context.Background()
	client := auth.GithubClient(os.Getenv("API_TOKEN"), ctx)

	switch os.Args[1] {
	case "createComment":
		buildInfo := configureBuildInfo(os.Args[2])
		issues.CreateIssueComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.Issue, buildInfo.formatted_build_info_git(), *client)
	case "getIssues":
		issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
	default:
		fmt.Println("Unknown command")
	}
}
