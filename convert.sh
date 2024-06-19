#!/bin/sh

filepath=$1

if [ ! $filepath ]; then 
  echo "Please supply a filepath to the CSV that you wish to convert"
  exit 1
fi

if [ ! -f $filepath ]; then
  echo "The specified file does not exist.\nPlease supply a valid filepath to the CSV that you wish to covnert."
  exit 1
fi

skip_headers=1
while IFS='|' read -r AlbumTitle AlbumWriter SubOrg AlbumFeatArtists ReleaseDate CatNum AppleURL SpotifyURL YouTubeURL PrestoURL Description Track1 Track1Dur Track2 Track2Dur Track3 Track3Dur RecordingLocation Producer Engineer Performers MFiT; do
    if ((skip_headers)); then
        ((skip_headers--))
    else
      echo "I got: $AlbumTitle $AlbumWriter $SubOrg"
    fi
done < $filepath
