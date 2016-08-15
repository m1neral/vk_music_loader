# VK Music Loader

<a href="https://vk.com"><img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjxzdmcgaGVpZ2h0PSI1MDhweCIgdmVyc2lvbj0iMS4xIiB2aWV3Qm94PSIwIDAgNzc3IDUwOCIgd2lkdGg9Ijc3N3B4IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnNrZXRjaD0iaHR0cDovL3d3dy5ib2hlbWlhbmNvZGluZy5jb20vc2tldGNoL25zIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+PHRpdGxlLz48ZGVzYy8+PGRlZnMvPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCIgaWQ9IlBhZ2UtMSIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiPjxwYXRoIGQ9Ik0wLjg0OTY4NDI2NywzNy43MTEyNjgyIEMtNC40NjcyMDkxMiw1LjI2NjgyMzg1IDE1Mi4zODExMDMsMjUuMzU0NDk3NCAxNTIuMzgxMTAzLDI1LjM1NDQ5NzQgQzE1Mi4zODExMDMsMjUuMzU0NDk3NCAyNDMuNDMyODc3LDI1NC4wMTA1ODYgMjc5LjMyMTg5NywyNTQuMDEwNTgyIEMzMTUuMjEwOTE3LDI1NC4wMTA1NzggMjk3LjkzMTAxOSw2MC4xMTY0MDIxIDI5Ny45MzEwMTksNjAuMTE2NDAyMSBDMjk3LjkzMTAxOSw2MC4xMTY0MDIxIDI1My40MDIwNDgsNDguNTI5MTAwNSAyNTMuNDAyMDQ5LDMwLjc2MTkwNDggQzI1My40MDIwNTEsMTIuOTk0NzA5IDI5Ny45MzEwMTksMC42MzQ5MjA2MzUgMjk3LjkzMTAxOSwwLjYzNDkyMDYzNSBDMjk3LjkzMTAxOSwwLjYzNDkyMDYzNSA0MTMuMTY4OTYzLDAuNjM0OTIyMTg4IDQyOC44NTk0ODIsMC42MzQ5MjA2MzUgQzQ0NC41NSwwLjYzNDkxOTA2MSA0NTAuNzk0MjQxLDI2LjEyNjk4NTQgNDUwLjc5NDI1Nyw0My4xMjE2OTMxIEM0NTAuNzk0MjcyLDYwLjExNjQwMDggNDUwLjc5NDI1NywyNTAuOTIwNjM1IDQ1MC43OTQyNTcsMjUwLjkyMDYzNSBMNDg2LjY4MzI3NywyNTAuOTIwNjM1IEM0ODYuNjgzMjc3LDI1MC45MjA2MzUgNTE4LjYzMDMxNSwxOTkuNTcyODA0IDU0My44MzcyNjksMTQ3LjQwNzQwNyBDNTY5LjA0NDIyNSw5NS4yNDIwMTE5IDU5OS42NjQ2MzQsMjUuMzU0NDk3NCA1OTkuNjY0NjM0LDI1LjM1NDQ5NzQgTDc1MS44NjA2NjQsMjUuMzU0NDk3NCBDNzUxLjg2MDY2NCwyNS4zNTQ0OTc0IDc3OS43NzQzNDcsMjYuMTIwOTQ5MiA3NzYuNDUxMjg5LDQ5LjI5ODU2OTggQzc3MS45MzA1NDUsODAuODI5ODA1NyA2NzAuNjc1NTMsMjMwLjU2NjI0NyA2NDkuNTEwNDk1LDI4MS44MTcwODggQzYzMy41NTk4MTksMzIwLjQ0MTQyNyA3MTYuNTE3Nzc5LDM3Mi43MTk2ODYgNzUxLjg2MDY2NCw0MjguNTg5NTc1IEM3NzQuNzk4NjY5LDQ2NC44NDk4ODEgNzc2LjQ1MTI4OSw1MDcuMzg2MjQzIDc3Ni40NTEyODksNTA3LjM4NjI0MyBMNTk1LjY3OTU2MSw1MDcuMzg2MjQzIEw1MDUuMjg5ODAzLDQwMi4zMjUwMjUgQzUwNS4yODk4MDMsNDAyLjMyNTAyNSA0ODYuNjgzMjc3LDM5NC42MDMxNzUgNDcyLjA1OTIyOCw0MDUuNDE0OTcyIEM0NTcuNDM1MTgsNDE2LjIyNjc3IDQ1Ni43NzMxNjQsNDM3Ljg1OTQxNiA0NTYuNzczMTY0LDQzNy44NTk0MTYgTDQ1Ni43NzMxNjQsNTA3LjM4NjI0MyBMMzE1LjIxMDkxNyw1MDcuMzg2MjQzIEMzMTUuMjEwOTE3LDUwNy4zODYyNDMgMjA2Ljg3OTI0NSw0NzAuMzA2ODc4IDExNS4xNjI4NiwzMDguMDg0NjU2IEMyMy40NDY0NjQ5LDE0NS44NjI0MzYgNi4xNjY1NzYxNiw3MC4xNTU3MTI2IDAuODQ5Njg0MjY3LDM3LjcxMTI2ODIgWiIgZmlsbD0iIzRBNEE0QSIgaWQ9InZrb250YWt0ZSIvPjwvZz48L3N2Zz4=" align="left" hspace="10" vspace="6"></a>

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
$ vk_music_loader -q QUERY_SEAR
    [ -app (or -app, --app, -application, '--application') your_standalone_app_id (default: 5377636) ]
    [ -count (or count, -count, --count, c, -c, --c) count_of_songs ]
    [ -folder (or -folder, --folder, path, -path, --path, -p) folder_path_to_download_music, default: 'music' ]
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

