package nexus

import (
	"mime/multipart"
	"os"
	"path/filepath"
)

func CreateBodyRequest(nexusParameter NexusParameter, writer *multipart.Writer) error {
	fileReadError := metadataAndFile(writer, nexusParameter.ZipedFrameworkPath, "maven2.asset1")

	if fileReadError != nil {
		return fileReadError
	}

	extensionReadError := metaDataAndExtension(writer, nexusParameter.Extension, "maven2.asset1.extension")

	if extensionReadError != nil {
		return extensionReadError
	}

	versionReadError := metaDataAndExtension(writer, nexusParameter.Version, "maven2.version")

	if versionReadError != nil {
		return versionReadError
	}

	artifactIdReadError := metaDataAndExtension(writer, nexusParameter.ArtifactId, "maven2.artifactId")

	if artifactIdReadError != nil {
		return artifactIdReadError
	}

	groupIdReadError := metaDataAndExtension(writer, nexusParameter.GroupId, "maven2.groupId")

	if groupIdReadError != nil {
		return groupIdReadError
	}

	if err := writer.Close(); err != nil {
		return err
	}

	return nil
}

func metaDataAndExtension(writer *multipart.Writer, value string, key string) error {
	if err := addKeyValueToWriter(writer, key, value); err != nil {
		return err
	}

	return nil
}

func addKeyValueToWriter(writer *multipart.Writer, key, value string) error {
	if err := writer.WriteField(key, value); err != nil {
		return err
	}

	return nil
}

func metadataAndFile(writer *multipart.Writer, value string, key string) error {
	absolutePath, err := filepath.Abs("../../" + value)

	if err != nil {
		return err
	}

	bytes, err := readFile(absolutePath)
	if err != nil {
		return err
	}

	if err = addFileToWriter(writer, bytes, key, absolutePath); err != nil {
		return err
	}

	return nil
}

func addFileToWriter(writer *multipart.Writer, bytes []byte, fn, f string) error {
	part, err := writer.CreateFormFile(fn, f)
	if err != nil {
		return err
	}

	if _, err = part.Write(bytes); err != nil {
		return err
	}

	return nil
}

func readFile(fileUrl string) ([]byte, error) {
	bytes, err := os.ReadFile(filepath.Clean(fileUrl))
	if err != nil {
		return nil, err
	}

	return bytes, nil
}
