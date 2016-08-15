# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vk_music_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'vk_music_loader'
  spec.version       = VkMusicLoader::VERSION
  spec.authors       = ['Anatoly Ryabov']
  spec.email         = ['a.ryabov1993@gmail.com']

  spec.summary       = 'Simple gem to download VK user/group audio playlist.'
  spec.description   = 'Download your VK playlist in one command'
  spec.homepage      = 'https://github.com/m1neral/vk_music_loader'
  spec.license       = 'MIT'
  spec.files         = Dir['{bin,lib}/**/*', 'README*', 'LICENSE*']
  spec.require_paths = ['lib']

  spec.add_dependency('launchy', '~> 2.0')
  spec.add_dependency('slop', '~> 4.4')
  spec.executables   << 'vk_music_loader'
end
