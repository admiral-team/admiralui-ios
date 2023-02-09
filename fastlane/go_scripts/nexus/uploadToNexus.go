package nexus

import (
	"bytes"
	"context"
	b64 "encoding/base64"
	"fmt"
	"io"
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

	_, writer := createMultipartFormData(nexus.Extension, nexus.ZipedFrameworkPath)

	body := &bytes.Buffer{}
	defer writer.Close()

	_ = writer.WriteField("maven2.groupId", nexus.GroupId)
	_ = writer.WriteField("maven2.artifactId", nexus.ArtifactId)
	_ = writer.WriteField("maven2.version", nexus.Version)
	_ = writer.WriteField("maven2.generate-pom", fmt.Sprintf("%t", true))
	_ = writer.WriteField("maven2.packaging", fmt.Sprintf("%t", true))
	_ = writer.WriteField("maven2.asset0", nexus.ZipedFrameworkPath)
	_ = writer.WriteField("maven2.asset0.extension", nexus.Extension)

	req, err := http.NewRequest("POST", url, body)
	if err != nil {
		return
	}
	token := b64.StdEncoding.EncodeToString([]byte(nexus.Username + ":" + nexus.Password))
	req.Header.Set("Content-Type", writer.FormDataContentType())
	req.Header.Set("Authorization", "Basic "+token)

	client := &http.Client{}
	response, error := client.Do(req)
	check(error)
	defer response.Body.Close()
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func createMultipartFormData(fieldName, fileName string) (bytes.Buffer, *multipart.Writer) {
	var b bytes.Buffer
	var err error
	w := multipart.NewWriter(&b)
	var fw io.Writer
	file := mustOpen(fileName)
	if fw, err = w.CreateFormFile(fieldName, file.Name()); err != nil {
		fmt.Println("Error: ", err)
	}
	if _, err = io.Copy(fw, file); err != nil {
		fmt.Println("Error: ", err)
	}
	w.Close()
	return b, w
}

func mustOpen(f string) *os.File {
	r, err := os.Open(f)
	if err != nil {
		pwd, _ := os.Getwd()
		fmt.Println("PWD: ", pwd)
		panic(err)
	}
	return r
}
