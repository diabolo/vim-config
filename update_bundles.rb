#!/usr/bin/env ruby

git_bundles = [
  "http://github.com/kana/vim-textobj-user.git",
  "http://github.com/nelstrom/vim-textobj-rubyblock.git",
  "http://github.com/tpope/vim-commentary.git",
  "http://github.com/tpope/vim-cucumber.git",
  "http://github.com/tpope/vim-eunuch.git",
  "http://github.com/tpope/vim-fugitive.git",
  "http://github.com/tpope/vim-git.git",
  "http://github.com/tpope/vim-haml.git",
  "http://github.com/tpope/vim-liquid.git",
  "http://github.com/tpope/vim-markdown.git",
  "http://github.com/tpope/vim-rails.git",
  "http://github.com/tpope/vim-ragtag.git",
  "http://github.com/tpope/vim-surround.git",
  "http://github.com/tpope/vim-vividchalk.git",
  "http://github.com/vim-ruby/vim-ruby.git",
  "http://github.com/wincent/Command-T.git",
  "http://github.com/greyblake/vim-preview.git",
  "http://github.com/mileszs/ack.vim.git",
  "http://github.com/altercation/vim-colors-solarized.git",
  "http://github.com/godlygeek/tabular.git",
  "http://github.com/vim-scripts/Gist.vim.git",
  "http://github.com/vim-scripts/IndexedSearch.git",
  "http://github.com/vim-scripts/jQuery.git",
  "https://github.com/vim-scripts/vimwiki",
  "https://github.com/kchmck/vim-coffee-script.git",
]

require 'fileutils'
require 'open-uri'

def ensure_system_ruby
end

def command_t(dir)
  FileUtils.cd(dir)
  puts "making command-t"
  ensure_system_ruby
  puts `rake make`
  FileUtils.cd('..')
end

def vim_preview
  gems = [
    "bluecloth",
  ]

  puts "checking gems for vim_preview"
  ensure_system_ruby
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

