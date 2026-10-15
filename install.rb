#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"

SCRIPT_DIR = __dir__
SKILLS = ["loom-summary"].freeze

TARGET_DIRS = [
  File.join(Dir.home, ".claude", "commands"),
  File.join(Dir.home, ".agents", "skills", "loom-summary"),
  File.join(Dir.home, ".pi", "agent", "skills", "loom-summary")
].freeze

def pi_dir?(dir)
  dir.end_with?("loom-summary")
end

def uninstall
  TARGET_DIRS.each do |dir|
    target = File.join(dir, pi_dir?(dir) ? "SKILL.md" : "loom-summary.md")
    if File.symlink?(target)
      File.unlink(target)
      puts "Removed #{target}"
    end
  end
  puts "Uninstall complete."
end

def install
  SKILLS.each do |skill|
    source = File.join(SCRIPT_DIR, "skills", skill, "SKILL.md")
    TARGET_DIRS.each do |dir|
      FileUtils.mkdir_p(dir)
      target = File.join(dir, pi_dir?(dir) ? "SKILL.md" : "#{skill}.md")
      File.unlink(target) if File.symlink?(target)
      File.symlink(source, target)
      puts "Linked #{target} -> #{source}"
    end
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
