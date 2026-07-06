#!/usr/bin/env ruby
# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"

require_relative "../install"

class InstallTest < Minitest::Test
  def setup
    @script_dir = Dir.mktmpdir
    @commands_dir = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(@script_dir, "skills", "loom-summary"))
    File.write(File.join(@script_dir, "skills", "loom-summary", "SKILL.md"), "# loom-summary")
  end

  def teardown
    FileUtils.remove_entry(@script_dir)
    FileUtils.remove_entry(@commands_dir)
  end

  def test_install_symlinks_each_skill_into_commands_dir
    install(script_dir: @script_dir, commands_dir: @commands_dir)

    target = File.join(@commands_dir, "loom-summary.md")
    assert File.symlink?(target)
    assert_equal File.join(@script_dir, "skills", "loom-summary", "SKILL.md"), File.readlink(target)
  end

  def test_install_replaces_an_existing_symlink
    stale_source = File.join(@script_dir, "stale.md")
    File.write(stale_source, "stale")
    target = File.join(@commands_dir, "loom-summary.md")
    File.symlink(stale_source, target)

    install(script_dir: @script_dir, commands_dir: @commands_dir)

    assert_equal File.join(@script_dir, "skills", "loom-summary", "SKILL.md"), File.readlink(target)
  end

  def test_uninstall_removes_the_symlink
    install(script_dir: @script_dir, commands_dir: @commands_dir)
    target = File.join(@commands_dir, "loom-summary.md")

    uninstall(commands_dir: @commands_dir)

    refute File.exist?(target)
  end

  def test_uninstall_is_a_no_op_when_nothing_is_installed
    uninstall(commands_dir: @commands_dir)

    refute File.exist?(File.join(@commands_dir, "loom-summary.md"))
  end
end
