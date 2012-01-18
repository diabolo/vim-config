#!/usr/bin/env ruby

git_bundles = [
  "http://github.com/tpope/vim-cucumber.git",
  "http://github.com/tpope/vim-fugitive.git",
  "http://github.com/tpope/vim-git.git",
  "http://github.com/tpope/vim-haml.git",
  "http://github.com/tpope/vim-markdown.git",
  "http://github.com/tpope/vim-rails.git",
  "http://github.com/tpope/vim-surround.git",
  "http://github.com/tpope/vim-vividchalk.git",
  "http://github.com/vim-ruby/vim-ruby.git",
  "http://github.com/vim-scripts/Gist.vim.git",
  "https://github.com/wincent/Command-T.git",
  "http://github.com/greyblake/vim-preview.git",
  "http://github.com/scrooloose/nerdcommenter.git",
  "https://github.com/mileszs/ack.vim.git",
  "http://github.com/altercation/vim-colors-solarized.git",
]

vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["jquery",        "12107", "syntax"],
]

require 'fileutils'
require 'open-uri'

def command_t(dir)
  FileUtils.cd(dir)
  puts "making command-t"
  puts `rvm use system`
  puts `rake make`
  FileUtils.cd('..')
end

def vim_preview
  gems = [
    "bluecloth",
  ]

  puts "checking gems for vim_preview"
  puts `rvm use system`
  gems.each do |gem|
    res=`gem list --local | grep #{gem}`
    puts "Missing GEM: #{gem}" unless res.match /#{gem}/
  end
end

bundles_dir = File.join(File.dirname(__FILE__), "bundle")
`mkdir #{bundles_dir}` # we may not have one yet
FileUtils.cd(bundles_dir)

puts "trashing everything (lookout!)"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '').downcase
  puts "unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
  command_t dir if dir=="command-t"
  vim_preview if dir=="vim-preview"
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end
