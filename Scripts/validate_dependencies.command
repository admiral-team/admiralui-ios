
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."

bundle exec fastlane validate_depenecy_managers use_current_branch:true
