package nexus

import (
	"bytes"
	"context"
	b64 "encoding/base64"
	"encoding/json"
	"fmt"
	"io"
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

	b, w := createMultipartFormData(nexus.Extension, nexus.ZipedFrameworkPath)

	values := map[string]interface{}{
		"maven2.groupId":          nexus.GroupId,
		"maven2.artifactId":       nexus.ArtifactId,
		"maven2.version":          nexus.Version,
		"maven2.generate-pom":     true,
		"maven2.packaging":        true,
		"maven2.asset0":           &b,
		"maven2.asset0.extension": nexus.Extension,
	}

	jsonValue, _ := json.Marshal(values)

	bytes := bytes.NewBuffer(jsonValue)

	req, err := http.NewRequest("POST", url, bytes)
	if err != nil {
		return
	}
	token := b64.StdEncoding.EncodeToString([]byte(nexus.Username + ":" + nexus.Password))
	req.Header.Set("Content-Type", w.FormDataContentType())
	req.Header.Set("Authorization", "Basic "+token)

	client := &http.Client{}
	response, error := client.Do(req)
	check(error)
	defer response.Body.Close()

	fmt.Println("response Status:", response.Status)
	fmt.Println("response Headers:", response.Header)
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("response Body:", string(body))
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
