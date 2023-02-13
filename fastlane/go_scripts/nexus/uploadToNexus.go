package nexus

import (
	"bytes"
	"context"
	"crypto/tls"
	b64 "encoding/base64"
	"fmt"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
)

func UploadToNexus(ctx context.Context, nexus NexusParameter) {
	fmt.Println("ArtifactId:", nexus.ArtifactId)
	fmt.Println("Extension:", nexus.Extension)
	fmt.Println("GroupId:", nexus.GroupId)
	fmt.Println("Repository:", nexus.Repository)
	fmt.Println("Version:", nexus.Version)
	fmt.Println("ZipedFrameworkPath:", nexus.ZipedFrameworkPath)
	fmt.Println("NexusUrl:", nexus.NexusUrl)

	url := nexus.NexusUrl + "/service/rest/v1/components?repository=" + nexus.Repository
	fmt.Println("url:", url)

	var requestBody bytes.Buffer
	writer := multipart.NewWriter(&requestBody)

	_ = writer.WriteField("maven2.groupId", nexus.GroupId)
	_ = writer.WriteField("maven2.artifactId", nexus.ArtifactId)
	_ = writer.WriteField("maven2.version", nexus.Version)
	_ = writer.WriteField("maven2.generate-pom", fmt.Sprintf("%t", true))
	_ = writer.WriteField("maven2.packaging", fmt.Sprintf("%t", true))

	file, err := os.Open(nexus.ZipedFrameworkPath)
	if err != nil {
		panic(err)
	}
	fileContents, err := ioutil.ReadAll(file)
	if err != nil {
		panic(err)
	}
	fi, err := file.Stat()
	if err != nil {
		panic(err)
	}
	file.Close()

	part, err := writer.CreateFormFile("maven2.asset1", fi.Name())
	if err != nil {
		panic(err)
	}
	part.Write(fileContents)
	writer.WriteField("maven2.asset1.extension", nexus.Extension)

	writer.Close()

	req, err := http.NewRequest("POST", url, &requestBody)
	if err != nil {
		panic(err)
	}
	token := b64.StdEncoding.EncodeToString([]byte(nexus.Username + ":" + nexus.Password))
	req.Header.Set("Content-Type", writer.FormDataContentType())
	req.Header.Set("Authorization", "Basic "+token)

	tr := &http.Transport{
		TLSClientConfig: &tls.Config{
			InsecureSkipVerify: true,
		},
	}

	client := &http.Client{
		Transport: tr,
	}

	response, error := client.Do(req)
	if error != nil {
		panic(err)
	}
	defer response.Body.Close()

	responseBody, err := ioutil.ReadAll(response.Body)
	if err != nil {
		panic(err)
	}
	fmt.Println(string(responseBody))
}
