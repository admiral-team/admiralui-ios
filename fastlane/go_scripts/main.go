package main

import (
	"log"

	"github.com/joho/godotenv"
)

func main() {
	envError := godotenv.Load(".env")
	envSecretError := godotenv.Load(".env.secret")

	if envError != nil || envSecretError != nil {
		log.Fatal("Cannot read .env file")
	}

	// ctx := context.Background()
	// client := auth.GetClient(os.Getenv("API_TOKEN"), ctx)

	// TODO: - Create single binary files to call different methods.

	// issues.CreateComment(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), 4, os.Args[1:], *client)
	// issues.GetIssues(ctx, os.Getenv("OWNER"), os.Getenv("REPO"), *client)
}
