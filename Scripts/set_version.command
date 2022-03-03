
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."

UPDATE_APP_VERSION=true

read -p "Enter external version: " EXTERNAL_VERSION
read -p "Enter internal version: " INTERNAL_VERSION
read -p "Update app version(y/n) ? " UPDATE_APP_VERSION_STRING
if [ "$UPDATE_APP_VERSION_STRING" == "n" ] || [ "$UPDATE_APP_VERSION_STRING" == "" ]; then UPDATE_APP_VERSION=false; fi
bundle exec fastlane set_version external_version:"$EXTERNAL_VERSION" internal_version:"$INTERNAL_VERSION" update_app_version:"$UPDATE_APP_VERSION"
