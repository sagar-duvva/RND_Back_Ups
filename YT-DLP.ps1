### YT-DLP ###

yt-dlp
yt-dlp --help

## Download Video
yt-dlp "URL"

## Download Playlist
yt-dlp --yes-playlist "URL"

## Presets
-t, --preset-alias PRESET   The following presets are available: mp3, aac, mp4, mkv, sleep.

yt-dlp -t mp3 "URL"
yt-dlp --preset-alias mp3 "URL"

# -t mp3                          -f 'ba[acodec^=mp3]/ba/b' -x --audio-format
#                                 mp3

# -t aac                          -f
#                                 'ba[acodec^=aac]/ba[acodec^=mp4a.40.]/ba/b'
#                                 -x --audio-format aac

# -t mp4                          --merge-output-format mp4 --remux-video mp4
#                                 -S vcodec:h264,lang,quality,res,fps,hdr:12,a
#                                 codec:aac

# -t mkv                          --merge-output-format mkv --remux-video mkv

# -t sleep                        --sleep-subtitles 5 --sleep-requests 0.75
#                                 --sleep-interval 10 --max-sleep-interval 20

# Download / Extract Audio-only
-x, --extract-audio             
# Convert video files to audio-only files (requires ffmpeg and ffprobe)

--audio-format FORMAT           
# Format to convert the audio to when -x is used. 
# (currently supported: best (default), aac, alac, flac, m4a, mp3, opus, vorbis, wav). 
# You can specify multiple rules using similar syntax as --remux-video

--audio-quality QUALITY         
# Specify ffmpeg audio quality to use when converting the audio with -x. 
# Insert a value between 0 (best) and 10 (worst) for VBR or a specific bitrate like 128K (default 5)


yt-dlp -x --audio-format mp3 --audio-quality 0 "https://www.youtube.com/watch?v=qmIC0_-7W4c"




# SponsorBlock Options:
# --sponsorblock-mark CATS        SponsorBlock categories to create chapters
#                                 for, separated by commas. Available
#                                 categories are sponsor, intro, outro,
#                                 selfpromo, preview, filler, interaction,
#                                 music_offtopic, hook, poi_highlight,
#                                 chapter, all and default (=all). You can
#                                 prefix the category with a "-" to exclude
#                                 it. See [1] for descriptions of the
#                                 categories. E.g. --sponsorblock-mark
#                                 all,-preview
#                                 [1] https://wiki.sponsor.ajay.app/w/Segment_Categories
# --sponsorblock-remove CATS      SponsorBlock categories to be removed from
#                                 the video file, separated by commas. If a
#                                 category is present in both mark and remove,
#                                 remove takes precedence. The syntax and
#                                 available categories are the same as for
#                                 --sponsorblock-mark except that "default"
#                                 refers to "all,-filler" and poi_highlight,
#                                 chapter are not available
# --sponsorblock-chapter-title TEMPLATE
#                                 An output template for the title of the
#                                 SponsorBlock chapters created by
#                                 --sponsorblock-mark. The only available
#                                 fields are start_time, end_time, category,
#                                 categories, name, category_names. Defaults
#                                 to "[SponsorBlock]: %(category_names)l"
# --no-sponsorblock               Disable both --sponsorblock-mark and
#                                 --sponsorblock-remove
# --sponsorblock-api URL          SponsorBlock API location, defaults to
#                                 https://sponsor.ajay.app


## Thumbnail Options:
# --write-thumbnail               Write thumbnail image to disk
# --no-write-thumbnail            Do not write thumbnail image to disk (default)
# --write-all-thumbnails          Write all thumbnail image formats to disk
# --list-thumbnails               List available thumbnails of each video.
#                                 Simulate unless --no-simulate is used
