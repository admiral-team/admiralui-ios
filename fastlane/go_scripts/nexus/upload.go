package nexus

import (
	"bytes"
	"fmt"
	"io"
	"mime/multipart"
	"net/http"
)

var (
	body   = new(bytes.Buffer)
	writer = multipart.NewWriter(body)
)

func (nexusParameter NexusParameter) Upload() error {
	if err := CreateBodyRequest(nexusParameter, writer); err != nil {
		return fmt.Errorf("%w", err)
	}

	req, err := nexusParameter.request()
	if err != nil {
		return err
	}

	resp, err := response(req)
	if err != nil {
		return err
	}

	defer func() {
		if err := resp.Body.Close(); err != nil {
			panic(err)
		}
	}()

	b, err := io.ReadAll(resp.Body)
	if !(resp.StatusCode == http.StatusOK || resp.StatusCode == http.StatusNoContent) || (err != nil) {
		return fmt.Errorf("HTTPStatusCode: '%d'; ResponseMessage: '%s'; ErrorMessage: '%w'", resp.StatusCode, string(b), err)
	}

	return nil
}

func (u NexusParameter) request() (*http.Request, error) {
	req, err := http.NewRequest("POST", u.NexusUrl, body)
	if err != nil {
		return nil, err
	}

	req.Header.Add("Content-Type", writer.FormDataContentType())
	req.SetBasicAuth(u.Username, u.Password)

	return req, nil
}

func response(req *http.Request) (*http.Response, error) {
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}

	return resp, nil
}
