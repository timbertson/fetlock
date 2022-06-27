# load a gemset + lockfile via bundler, and export a JSON suitable for fetlock
require 'bundler'
require 'json'

cmd = ARGV.shift

case cmd
when "lock"
  lockfile_path = ARGV.fetch(0)
  lockfile = Dir.chdir(File.dirname(lockfile_path)) do ||
    Bundler::LockfileParser.new(File.basename(lockfile_path))
  end
  # puts lockfile.inspect
  toplevel_names = lockfile.dependencies.values.map(&:name).reject {|dep| dep == 'bundler' }
  specs = lockfile.specs.sort_by(&:name).map do |spec|
    {
      name: spec.name,
      version: spec.version,
      repository: spec.source.remotes.first,
      dependencies: spec.dependencies.map(&:name).sort,
    }
  end

  puts(JSON.pretty_generate({
    toplevel: toplevel_names,
    specs: specs
  }))
else
  raise "Unknown command: #{cmd}"
end
