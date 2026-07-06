#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"

SCRIPT_DIR = __dir__
COMMANDS_DIR = File.join(Dir.home, ".claude", "commands")
SKILLS = ["loom-summary"].freeze

def uninstall(commands_dir: COMMANDS_DIR)
  SKILLS.each do |skill|
    target = File.join(commands_dir, "#{skill}.md")
    if File.symlink?(target)
      File.unlink(target)
      puts "Removed #{target}"
    else
      puts "No symlink found for #{skill}"
    end
  end
  puts "Uninstall complete."
end

def install(script_dir: SCRIPT_DIR, commands_dir: COMMANDS_DIR)
  FileUtils.mkdir_p(commands_dir)
  SKILLS.each do |skill|
    source = File.join(script_dir, "skills", skill, "SKILL.md")
    target = File.join(commands_dir, "#{skill}.md")
    File.unlink(target) if File.symlink?(target)
    File.symlink(source, target)
    puts "Linked #{target} -> #{source}"
  end
  puts "Install complete."
end

if $PROGRAM_NAME == __FILE__
  if ARGV.first == "--uninstall"
    uninstall
  else
    install
  end
end
