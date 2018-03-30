#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'open-uri'
require 'fileutils'
require 'net/https'

# github username
username = "z0mbix"
backup_directory = "#{ENV['HOME']}/github-backups"
time = Time.new
uri = URI.parse("https://api.github.com/users/#{username}/repos")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
out = response.body
data = JSON.parse out
repos = []
data.each do |r|
  repos.push(r['name'])
end

unless File.directory?(backup_directory)
  FileUtils.mkdir_p(backup_directory)
end

repos.each do |repository|
  repo_backup_dir = "#{backup_directory}/#{repository}"
  #puts "Backing up repository: #{repository} to #{backup_dir}"
  if File.directory?(repo_backup_dir)
    Dir.chdir(repo_backup_dir)
    system "git pull -q git://github.com/#{username}/#{repository}.git"
  else
    system "git clone git://github.com/#{username}/#{repository}.git #{repo_backup_dir}"
  end
end
