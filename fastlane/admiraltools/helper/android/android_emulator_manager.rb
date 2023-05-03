# frozen_string_literal: true
require_relative '../system/system'

class AndroidEmulatorManager
  attr_accessor :adb_path, :emulator_path

  def initialize(adb_path:, emulator_path:)
    @adb_path = adb_path
    @emulator_path = emulator_path
  end

  def start_emulator_by_name(name)
    system("nohup #{@emulator_path} -avd #{name} >/dev/null 2>&1 &")
  end

  def kill_emulator_by_name(name)
    running_emulator_id_list.each do |id|
      current_name = emulator_name_by_id(id)
      if current_name == name
        kill_emulator_by_id(id)
        break
      end
    end
  end

  def kill_emulator_by_id(id)
    system("#{adb_path} -s #{id} emu kill")
  end

  def emulator_name_by_id(id)
    str = syscall("#{adb_path} -s #{id} emu avd name").split("\n")[0]
    str.nil? ? str : str.strip
  end

  def running_emulator_id_list
    syscall("#{adb_path} devices -l")
      .split("\n")
      .select { |str| str.start_with?('emulator-') }
      .map { |str| str.extract_by_regex(/emulator-[0-9]*/) }
      .select { |str| !str.nil? && !str.empty? }
  end

  def emulator_list
    syscall("#{emulator_path} -list-avds").split("\n")
  end
end
