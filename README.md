# VK Music Loader

<a href="https://vk.com"><img src="https://cdn2.iconfinder.com/data/icons/vkontakte-3/154/api-vk-vkontakte-programming-128.png" align="left" hspace="10" vspace="6" width="50" height="50"></a>

**VK Music Loader** is a simple CLI Ruby gem to download music from VK (ВКонта́кте) ~~using easy and convenient way of authorization  - [Implicit Flow](https://new.vk.com/dev/implicit_flow_user)~~
using [mirror of VK Audio API](http://api.xn--41a.ws/)
This gem aimed at Ruby 2.0 or later.

## Installation

```sh
$ gem install vk_music_loader
```

## Usage

~~To login you will need [create Standalone Application](https://new.vk.com/editapp?act=create) or use the author's application (default APP ID: `5377636`)~~
From December 16, 2016, the public API for working with audio files will be disabled. 
Existing methods for the audio section will be unavailable for calling, except for methods regarding audio file uploads.
([source](source))

So you need to use a [mirror of VK Audio API](http://api.xn--41a.ws/) and buy an authentication key: http://api.xn--41a.ws/addmoney/.
I think 1$ is enough for a long time (100k requests) for personal use or also you can write to me to share my key.

```sh
$ vk_music_loader -id USER_OR_GROUP_ID
$ vk_music_loader -q QUERY_SEARCH
  [ -key (or key, --key, -k) your_auth_key (need only enter the first time after it is saved) ]
  [ -count (or count, -count, --count, c, -c, --c) count_of_songs (default: 300) ]
  [ -folder (or -folder, --folder, path, -path, --path, -p) folder_path_to_download_music (default: 'music') ]
  [ -random (or  --random, shuffle, -shuffle, --shuffle, -r) shuffle_download_flag (default: false) ]
```

If the song is already in the folder, it will not be downloaded.
## Usage examples
```sh
# Download all music from VK Public:
$ vk_music_loader -id -45172096

# Download 20 first songs from user in specified folder:
$ vk_music_loader -id 243556640 -с 20 -p '/Volumes/FLASHKA/music_in_da_bass_car'

# Download 4 random Eminem Song:
$ vk_music_loader -q 'Eminem' -c 4 -r
```
![](https://github.com/m1neral/vk_music_loader/blob/gh-wiki/wiki_src/record.gif)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/m1neral/vk_music_loader.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

