package main

import (
	"context"
	"fmt"
	"log"
	"main/auth"
	"main/issues"
	"main/pullRequests"
	"main/release"
	"main/telegram"
	"os"
	"strconv"

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
		client := auth.GithubClient(os.Args[3], ctx)
		telegramChatId, _ := strconv.Atoi(os.Args[4])
		buildInfo := configureBuildInfo(os.Args[2])
		formatedBuildInfo := buildInfo.formatted_build_info_git()
		formatedBuildInfoTelegram := buildInfo.formatted_build_info_telegram()
		telegram.SendTextToTelegramChat(telegramChatId, formatedBuildInfoTelegram, os.Args[5], buildInfo.Build_url)
		issues.CreateComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.PullNumber, formatedBuildInfo, *client)
		pullRequests.LinkPullRequest(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.PullNumber, strconv.Itoa(buildInfo.Issue), *client)
	case "getIssues":
		client := auth.GithubClient(os.Args[3], ctx)
		issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
	case "createRelease":
		buildInfo := configureBuildInfo(os.Args[2])
		release.CreateRelease(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.External_version, os.Args[3])
	case "build_failed":
		buildInfo := configureBuildInfo(os.Args[2])
		fmt.Println("configureBuildInfo succed", buildInfo)
		formatedBuildInfoFailed := buildInfo.build_failed_info()
		telegramChatId, _ := strconv.Atoi(buildInfo.TelegramChatId)
		telegram.SendTextToTelegramChat(telegramChatId, formatedBuildInfoFailed, buildInfo.TelegramToken, "")
	default:
		fmt.Println("Unknown command")
	}
}
