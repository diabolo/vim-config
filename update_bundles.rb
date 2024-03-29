#!/usr/bin/env ruby

git_bundles = [
  "https://github.com/junegunn/fzf.git",
  "https://github.com/junegunn/fzf.vim.git",
  "http://github.com/kana/vim-textobj-user.git",
  "http://github.com/nelstrom/vim-textobj-rubyblock.git",
  "http://github.com/tpope/vim-commentary.git",
  "http://github.com/tpope/vim-cucumber.git",
  "http://github.com/tpope/vim-eunuch.git",
  "http://github.com/tpope/vim-fugitive.git",
  "http://github.com/tpope/vim-git.git",
  "http://github.com/tpope/vim-haml.git",
  "http://github.com/tpope/vim-liquid.git",
  "http://github.com/tpope/vim-rails.git",
  "http://github.com/tpope/vim-ragtag.git",
  "http://github.com/tpope/vim-surround.git",
  "http://github.com/tpope/vim-vividchalk.git",
  "http://github.com/vim-ruby/vim-ruby.git",
  "http://github.com/greyblake/vim-preview.git",
  "http://github.com/mileszs/ack.vim.git",
  "http://github.com/altercation/vim-colors-solarized.git",
  "http://github.com/godlygeek/tabular.git",
  "http://github.com/vim-scripts/Gist.vim.git",
  "http://github.com/vim-scripts/IndexedSearch.git",
  "http://github.com/vim-scripts/jQuery.git",
  "https://github.com/kchmck/vim-coffee-script.git",
  "https://github.com/othree/html5.vim.git",
  "https://github.com/vim-scripts/Rename",
  "https://github.com/bling/vim-airline.git",
  "https://github.com/edkolev/tmuxline.vim",
  'https://github.com/slim-template/vim-slim.git',
  'https://github.com/yssl/QFEnter.git',
  'https://github.com/heartsentwined/vim-emblem.git',
  'https://github.com/tpope/vim-projectionist.git',
  'https://github.com/moll/vim-bbye.git',
  'https://github.com/elixir-lang/vim-elixir.git',
  'https://github.com/slashmili/alchemist.vim.git',
  'https://github.com/reedes/vim-pencil',
  'https://github.com/reedes/vim-colors-pencil',
  "http://github.com/tpope/vim-markdown.git",
  'https://github.com/junegunn/goyo.vim',
  'https://github.com/junegunn/limelight.vim'
]

require 'fileutils'
require 'open-uri'

def vim_preview
  gems = [
    "bluecloth",
  ]

  puts "checking gems for vim_preview"
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
  vim_preview if dir=="vim-preview"
end

