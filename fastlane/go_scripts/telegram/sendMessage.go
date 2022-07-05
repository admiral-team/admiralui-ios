package telegram

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"strconv"
)

func SendTextToTelegramChat(chatId int, text string, token string) {
	var telegramApi string = "https://api.telegram.org/bot" + token + "/sendMessage"
	parseMode := "HTML"
	response, err := http.PostForm(
		telegramApi,
		url.Values{
			"chat_id":    {strconv.Itoa(chatId)},
			"parse_mode": {parseMode},
			"text":       {text},
		})

	if err != nil {
		fmt.Println("error when posting text to the chat:", err.Error())
	}

	defer response.Body.Close()

	var bodyBytes, errRead = ioutil.ReadAll(response.Body)
	if errRead != nil {
		fmt.Println("error in parsing telegram answer", errRead.Error())
	}
	bodyString := string(bodyBytes)
	fmt.Println("Body of Telegram Response:", bodyString)
}
