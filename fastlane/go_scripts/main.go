package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"main/auth"
	"main/issues"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

func main() {
	envError := godotenv.Load(".env")
	envSecretError := godotenv.Load(".env.secret")

	if envError != nil || envSecretError != nil {
		log.Fatal("Cannot read .env file")
	}

	buildInfo := BuildInfo{}

	jsonBody := os.Args[1]
	err := json.Unmarshal([]byte(jsonBody), &buildInfo)
	if err != nil {
		fmt.Println("Cannot Parse JSON From Command Line....", err)
	}

	ctx := context.Background()
	client := auth.GetClient(os.Getenv("API_TOKEN"), ctx)

	issueNumber, _ := strconv.Atoi(buildInfo.Issue)

	// TODO: - Create single binary files to call different methods.

	issues.CreateComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), issueNumber, formatted_build_info_git(buildInfo), *client)
	// issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
}
