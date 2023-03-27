DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd "../Tools/CreateXCFramework"

swift build && swift run