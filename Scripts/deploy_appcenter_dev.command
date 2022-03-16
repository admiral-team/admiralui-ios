
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."

read -p "Enter issue name(Press enter to skip this step): " ISSUE_NAME

read -p "Skip building and archiving app(y/n)? " SKIP_ARCHIVE_STRING
SKIP_ARCHIVE=false
if [ "$SKIP_ARCHIVE_STRING" == "y" ] || [ "$SKIP_ARCHIVE_STRING" == "yes" ]; then SKIP_ARCHIVE=true; fi

read -p "Skip Git comment(y/n)? " SKIP_GIT_COMMENT_STRING
SKIP_GIT_COMMENT=false
if [ "$SKIP_GIT_COMMENT_STRING" == "y" ] || [ "$SKIP_GIT_COMMENT_STRING" == "yes" ]; then SKIP_GIT_COMMENT_STRING=true; fi

bundle exec fastlane deploy_appcenter_dev issue_name:"$ISSUE_NAME" skip_archive:"$SKIP_ARCHIVE" skip_git_comment:"$SKIP_GIT_COMMENT"