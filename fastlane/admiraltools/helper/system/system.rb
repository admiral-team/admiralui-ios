def syscall(*cmd)
  require 'open3'
  stdout, = Open3.capture3(*cmd)
  stdout
end

def syscall_safe(*cmd)
  syscall(*cmd)
rescue StandardError
  ''
end

class String
  def extract_by_regex(regex)
    (regex.match(self) || [])[0]
  end
end
