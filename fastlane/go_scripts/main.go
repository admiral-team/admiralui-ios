package main

import (
	"context"
	"fmt"
	"log"
	"main/auth"
	"main/issues"
	"main/nexus"
	"main/pullRequests"
	"main/telegram"
	"os"
	"strconv"

	"github.com/admiral-team/admiral-tools/client"
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
		telegram.SendTextToTelegramChat(telegramChatId, formatedBuildInfoTelegram, os.Args[5])
		issues.CreateComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.PullNumber, formatedBuildInfo, *client)
		pullRequests.LinkPullRequest(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), buildInfo.PullNumber, strconv.Itoa(buildInfo.Issue), *client)
	case "getIssues":
		client := auth.GithubClient(os.Args[3], ctx)
		issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
	case "createRelease":
		client.ReleaseIos(os.Args[3], os.Args[5], os.Args[6])
	case "build_failed":
		buildInfo := configureBuildInfo(os.Args[2])
		formatedBuildInfoFailed := buildInfo.build_failed_info(os.Args[5])
		telegramChatId, _ := strconv.Atoi(os.Args[3])
		telegram.SendTextToTelegramChat(telegramChatId, formatedBuildInfoFailed, os.Args[4])
	case "uploadFigmaPdf":
		token := os.Args[2]
		id := os.Args[3]
		path := os.Args[4]
		client.LoadDocumentation(token, id, path)
	case "uploadNexusLib":
		nexusItem := nexus.ConfigureNexusParameters(os.Args[2])
		if err := nexusItem.Upload(); err != nil {
			log.Fatal(err)
		}
	default:
		fmt.Println("Unknown command")
	}
}
