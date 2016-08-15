# VK Music Loader

<a href="https://vk.com"><img src="https://cdn2.iconfinder.com/data/icons/vkontakte-3/154/api-vk-vkontakte-programming-128.png" align="left" hspace="10" vspace="6" width="50" height="50"></a>

**VK Music Loader** is a simple CLI Ruby gem to download music from VK (ВКонта́кте) using easy and convenient way of authorization  - [Implicit Flow](https://new.vk.com/dev/implicit_flow_user)
This gem aimed at Ruby 2.0 or later.

## Installation

```sh
$ gem install vk_music_loader
```

## Usage

To login you will need [create Standalone Application](https://new.vk.com/editapp?act=create) or use the author's application (default APP ID: `5377636`)

```sh
$ vk_music_loader -id USER_OR_GROUP_ID
$ vk_music_loader -q QUERY_SEARCH
  [ -app (or -app, --app, -application, --application) your_standalone_app_id (default: 5377636) ]
  [ -count (or count, -count, --count, c, -c, --c) count_of_songs ]
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

