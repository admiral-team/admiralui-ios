
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."

bundle exec fastlane download_icons
bundle exec fastlane download_symbols