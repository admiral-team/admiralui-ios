require './build_info.rb'

def replace(file:, regex:, with:)
  content = File.read(file)
  new_content = content.gsub(regex, with)
  File.open(file, "w") {|file| file.puts new_content }
end

def extract_issue_name(branch_name:)
  branch_array = branch_name.split("/")
  last_element = branch_array.last.split("-").first
  last_element
end

def validate_cocoapods_imports(directory:, imports:)
  file_paths = Dir[File.join(directory, '**', '*.swift')]
  imports = imports.map { |i| "import #{i}" }
  error_file_paths = []
  
  file_paths.each do |path|
    file = File.read(path)
  
    if imports.any? { |i| file.include?(i) } && (!file.include?('#if !COCOAPODS') || !file.include?('#endif'))
      error_file_paths.push(path)
    end
  end
  
  if !error_file_paths.empty?
    raise "Missing #if !COCOAPODS #endif in files:\n#{error_file_paths.join('\n')}"
  end
end

def jira_get_done_issues(fix_version:)
  issues = jira_get_issues(
    project: ENV['JIRA_PROJECT_NAME'],
    labels: ['iOS'],
    fix_version: fix_version,
    status: "Выполнено"
  )
end

def jira_issue_link(key:)
  File.join(ENV['JIRA_SITE'], 'browse', key)
end

def send_message(build_info:, chat_ids:)
  info = formatted_build_info_telegram(build_info: build_info)
  send_telegram_message(text: info["text"], chat_ids: chat_ids, url_buttons: info["url_buttons"])
end

def send_telegram_message(text:, chat_ids:, url_buttons:)
  telegram_send_message(
    api_token: ENV['TELEGRAM_API_TOKEN'],
    chat_ids: chat_ids,
    text: text,
    parse_mode: "HTML",
    url_buttons: url_buttons
  )
end
